#include <chrono>
#include <cmath>
#include <pthread.h>
#include <unistd.h>

#include <libplayercore/playercore.h>
#include <QtCore/qglobal.h>
#include <QtCore/QDebug>
#include <QtCore/QThread>
#include <QtCore/QMutex>
#include <QtCore/QTimer>
#include <QtCore/QObject>
#include <QtCore/QVector>
#include <QtCore/QCoreApplication>

#if QT_VERSION < QT_VERSION_CHECK(5, 0, 0)
  #include <QtGui/QApplication>
#else
  #include <QtWidgets/QApplication>
#endif

#include <QtCore/QScopedPointer>

#include <trikControl/brickInterface.h>
#include <trikControl/brickFactory.h>
#include "gyroscope.h"
#include "trikMotors.h"

#define TRIK_WHEEL_BASE 0.17
#define TRIK_VEL_TO_POW_RATE 5
#define MAX_WHEEL_FORW_SPEED 0.566759 // from playerv
#define MAX_WHEEL_BACKW_SPEED 0.166759 // from playerv
#define MAX_WHEEL_TRIK_SPEED 0.3 // m/s
#define TRIK_LENGTH 0.17
// Normalize angle to domain -pi, pi
#ifndef NORMALIZE
   #define NORMALIZE(z) atan2(sin(z), cos(z))
#endif

QMutex mutex, gyroMutex;
bool appThreadStarted, brickThreadStarted, gyroThreadStarted;

class TrikMotors : public ThreadedDriver {
private:
    std::chrono::system_clock::time_point timestamp_ms;
    player_devaddr_t position2d_id;
    player_devaddr_t ranger_id;
    player_position2d_data_t pos_data;
    player_ranger_data_range_t rng_data;
    player_ranger_data_intns_t intensity_data;
    trikControl::BrickInterface *brick;
    trikControl::MotorInterface *leftMotor, *rightMotor;
    trikControl::SensorInterface *irSensor;
    QVector<qreal> gyroAvg; // For gyroscope calibration
    qreal oldGyro;
    SuperCosmoGyroIntegrator3000 *gyroIntegrator;

    virtual void Main();
    void ProcessPos2dGeomReq();
    void ProcessRngGeomReq();
    void ProcessPos2dVelCmd(player_msghdr_t* hdr, player_position2d_cmd_vel_t &data);
    void ProcessPos2dPosCmd(player_msghdr_t* hdr, player_position2d_cmd_pos_t &data);
    void ProcessPos2dCarCmd(player_msghdr_t* hdr, player_position2d_cmd_car_t &data);
    void UpdatePosData(void);
    void UpdateRngData(void);

public:
    TrikMotors(ConfigFile *cf, int section);
    ~TrikMotors(void);

    virtual int MainSetup();
    virtual void MainQuit();
 
    // This method will be invoked on each incoming message
    virtual int ProcessMessage(QueuePointer &resp_queue, 
                               player_msghdr * hdr,
                               void * data);
};

// Create and return a pointer to a new instance of this driver. 
Driver* TrikMotors_Init(ConfigFile* cf, int section) {
    return((Driver*)(new TrikMotors(cf, section)));
}

// Add the driver into the given driver table, indicating which interface the
// driver can support and how to create a driver instance.
void TrikMotors_Register(DriverTable* table) {
    table->AddDriver("trikmotors", TrikMotors_Init);
}

////////////////////////////////////////////////////////////////////////////////
// Extra stuff for building a shared object.

// need the extern to avoid C++ name-mangling
extern "C" {
    int player_driver_init(DriverTable* table) {
        puts("Motors driver initializing");
        TrikMotors_Register(table);
        puts("Motors driver done");
        return(0);
    }
}

////////////////////////////////////////////////////////////////////////////////
// Constructor. Retrieve options from the configuration file and do any
// pre-Setup() setup.
TrikMotors::TrikMotors(ConfigFile* cf, int section)
    : ThreadedDriver(cf, section) {

    timestamp_ms = std::chrono::high_resolution_clock::from_time_t(0);
    oldGyro = 0;

    memset(&pos_data, 0, sizeof(player_position2d_data_t));
    memset(&rng_data, 0, sizeof(player_ranger_data_range_t)); 

    // Create position2d interface
    if (cf->ReadDeviceAddr(&position2d_id, section,
                            "provides", PLAYER_POSITION2D_CODE, -1, NULL)) {
        PLAYER_ERROR("Could not read position2d ID ");
        SetError(-1);
        return;
    }
    if (AddInterface(position2d_id)) {
        PLAYER_ERROR("Could not add position2d interface ");
        SetError(-1);
        return;
    }

    // Create ranger interface
    if (cf->ReadDeviceAddr(&ranger_id, section, 
                            "provides", PLAYER_RANGER_CODE, -1, NULL)) {
        PLAYER_ERROR("Could not read ranger ID ");
        SetError(-1);
        return;
    }
    if (AddInterface(ranger_id)) {
        PLAYER_ERROR("Could not add ranger interface ");
        SetError(-1);
        return;
    }
}

TrikMotors::~TrikMotors() {
    brick = NULL;
}

class SuperCosmoThread3000 : public QThread
{
private:
    virtual void run()
    {
        appThreadStarted = true;
        mutex.lock();
        // QApplication arguments
        char *arg0 = new char[1];
        *arg0 = '\0';
        char *arg1 = new char[5];
        arg1[0] = '-';
        arg1[1] = 'q';
        arg1[2] = 'w';
        arg1[3] = 's';
        arg1[4] = '\0';
        char **argv = new char*[2];
        argv[0] = arg0;
        argv[1] = arg1;
        int Argc = 2;
        int &argc = Argc;

        QApplication *app = new QApplication(argc, argv);
        PLAYER_MSG0(0, "App created\n");
        mutex.unlock();
        app->exec();
    }
};

class SuperCosmoThread3001 : public QThread
{
public:
    SuperCosmoThread3001(trikControl::BrickInterface *&brick, trikControl::MotorInterface *&leftMotor, 
                         trikControl::MotorInterface *&rightMotor, trikControl::SensorInterface *&irSensor,
                         QVector<qreal> &gyroAvg,
                         SuperCosmoGyroIntegrator3000 *&gyroIntegrator)
        : brick(brick)
        , leftMotor(leftMotor)
        , rightMotor(rightMotor)
        , irSensor(irSensor)
        , gyroAvg(gyroAvg)
        , gyroIntegrator(gyroIntegrator)
    {
    }

private:
    trikControl::BrickInterface *&brick;
    trikControl::MotorInterface *&leftMotor;
    trikControl::MotorInterface *&rightMotor;
    trikControl::SensorInterface *&irSensor;
    QVector<qreal> &gyroAvg;
    SuperCosmoGyroIntegrator3000 *&gyroIntegrator;


    virtual void run()
    {
        brickThreadStarted = true;
        mutex.lock();
        brick = trikControl::BrickFactory::create("../trik", "../trik");
        PLAYER_MSG0(0, "Brick created\n"); 

        leftMotor = brick->motor("M1");
        rightMotor = brick->motor("M3");
        irSensor = brick->sensor("A1");
        PLAYER_MSG0(0, "Motor driver is ready\n");


        mutex.unlock();

        // Calibrate gyroscope
        gyroThreadStarted = true;
        gyroMutex.lock();
        gyroAvg = {0.0, 0.0, 0.0};
        for (int i = 0; i < 100; ++i) {
            QApplication::processEvents();
            usleep(40000);
            auto const reading = brick->gyroscope()->read();
            gyroAvg[0] += reading[0];
            gyroAvg[1] += reading[1];
            gyroAvg[2] += reading[2];
            PLAYER_MSG4(1, " i=%d,%d, %d, %d", i, reading[0], reading[1], reading[2]);
        }
        gyroAvg[0] /= 100;
        gyroAvg[1] /= 100;
        gyroAvg[2] /= 100;

        gyroIntegrator = new SuperCosmoGyroIntegrator3000(gyroAvg[2]);
        gyroIntegrator->moveToThread(brick->thread());
        QObject::connect(brick->gyroscope(), SIGNAL(newData(QVector<int>,trikKernel::TimeVal)), 
                        gyroIntegrator, SLOT(onNewData(QVector<int>,trikKernel::TimeVal)), Qt::DirectConnection);
        gyroMutex.unlock();

        exec();
    }
};


////////////////////////////////////////////////////////////////////////////////
// Set up the device.  Return 0 if things go well, and -1 otherwise.
int TrikMotors::MainSetup() {
    PLAYER_MSG0(0, "Motors driver initialising");

    SuperCosmoThread3000 *thread = new SuperCosmoThread3000;
    thread->start();
    sleep(1);
    SuperCosmoThread3001 *thread2 = new SuperCosmoThread3001(brick, leftMotor, rightMotor, irSensor, gyroAvg, gyroIntegrator);
    mutex.lock();
    mutex.unlock();
    thread2->start();


    //PLAYER_MSG3(1, "main %f, %f, %f", gyroAvg[0], gyroAvg[1], gyroAvg[2]);
    
    timestamp_ms = std::chrono::high_resolution_clock::now();

    StartThread();
    PLAYER_MSG0(0, "Thread started\n");

    return 0;
}

////////////////////////////////////////////////////////////////////////////////
// Shutdown the device
void TrikMotors::MainQuit() {
    PLAYER_MSG0(0, "Shutting Motors down\n"); 

    StopThread();

    leftMotor->powerOff();
    rightMotor->powerOff();
    leftMotor  = NULL;
    rightMotor = NULL;
    irSensor   = NULL;

    PLAYER_MSG0(0, "Motors has been shutdown\n"); 

    return;
}

////////////////////////////////////////////////////////////////////////////////
// Main function for device thread
void TrikMotors::Main() {
    // The main loop; interact with the device here
    for ( ; ; )
    {
        // test if we are supposed to cancel
        pthread_testcancel();
              
        // process incoming messages; calls ProcessMessage() on each pending message 
        ProcessMessages();

        // poll position of TRIK 
        UpdatePosData();

        // poll ranger data
        UpdateRngData();

        // Sleep (you might, for example, block on a read() instead)
        usleep(100000);
    }
}



int TrikMotors::ProcessMessage(QueuePointer & resp_queue, 
                               player_msghdr * hdr,
                               void * data) {

    // Check for capability requests
    HANDLE_CAPABILITY_REQUEST (ranger_id, resp_queue, hdr, data, PLAYER_MSGTYPE_REQ, PLAYER_CAPABILTIES_REQ);
    HANDLE_CAPABILITY_REQUEST (ranger_id, resp_queue, hdr, data, PLAYER_MSGTYPE_REQ, PLAYER_RANGER_REQ_GET_GEOM);
    HANDLE_CAPABILITY_REQUEST (ranger_id, resp_queue, hdr, data, PLAYER_MSGTYPE_REQ, PLAYER_RANGER_REQ_GET_CONFIG);

    if (Message::MatchMessage (hdr, PLAYER_MSGTYPE_REQ, PLAYER_RANGER_REQ_GET_GEOM, ranger_id))
    {
        ProcessRngGeomReq();
        return 0;
    }
    else if (Message::MatchMessage (hdr, PLAYER_MSGTYPE_REQ, PLAYER_RANGER_REQ_GET_CONFIG, ranger_id))
    {
        player_ranger_config_t rangerConfig;
        rangerConfig.min_angle = -0.1f; // rad
        rangerConfig.max_angle = 0.1f; // rad
        rangerConfig.angular_res = 0.01f; // rad
        rangerConfig.min_range = 0.08f; // m
        rangerConfig.max_range = 0.8f; // m
        rangerConfig.range_res = 0.01f; // m
        rangerConfig.frequency = 100.0f;

        QApplication::processEvents();
        Publish(ranger_id, resp_queue, PLAYER_MSGTYPE_RESP_ACK, PLAYER_RANGER_REQ_GET_CONFIG, &rangerConfig, sizeof (rangerConfig), NULL);
        
        return 0;
    }
    else if (Message::MatchMessage(hdr, PLAYER_MSGTYPE_CMD, 
                              PLAYER_POSITION2D_CMD_POS, position2d_id)) 
    { 
        assert(hdr->size == sizeof(player_position2d_cmd_pos_t)); 
        ProcessPos2dPosCmd(hdr, *reinterpret_cast<player_position2d_cmd_pos_t *>(data)); 
        return 0; 
    }
    else if (Message::MatchMessage(hdr, PLAYER_MSGTYPE_CMD, 
                                  PLAYER_POSITION2D_CMD_VEL, position2d_id)) 
    { 
        assert(hdr->size == sizeof(player_position2d_cmd_vel_t)); 
        ProcessPos2dVelCmd(hdr, *reinterpret_cast<player_position2d_cmd_vel_t *>(data)); 
        return 0; 
    }
    else if (Message::MatchMessage(hdr, PLAYER_MSGTYPE_CMD,
                                   PLAYER_POSITION2D_CMD_CAR, position2d_id))
    {
        assert(hdr->size == sizeof(player_position2d_cmd_car_t));
        ProcessPos2dCarCmd(hdr, *reinterpret_cast<player_position2d_cmd_car_t *>(data));
        return 0;
    }
    else if (Message::MatchMessage(hdr, PLAYER_MSGTYPE_REQ, 
                                  PLAYER_POSITION2D_REQ_MOTOR_POWER, position2d_id)) 
    { 
        this->Publish(position2d_id, resp_queue, 
                      PLAYER_MSGTYPE_RESP_ACK, PLAYER_POSITION2D_REQ_MOTOR_POWER); 
        return 0; 
    }
    else if (Message::MatchMessage(hdr, PLAYER_MSGTYPE_REQ, 
                                  PLAYER_POSITION2D_REQ_GET_GEOM, position2d_id)) 
    { 
        ProcessPos2dGeomReq(); 
        return 0; 
    }

    // Tell the caller that you don't know how to handle this message 
    return -1;
}

void TrikMotors::UpdatePosData(void) {
    std::chrono::system_clock::time_point new_timestamp_ms;
    int p1, p2;
    qreal v1, v2, v, radius, avgRadius, rotationRate;
    qreal theta, dx, dy, dtheta, delta_x, delta_y, delta_theta;
    int dt;
    
    // Robot's current data
    if (!brickThreadStarted) return;
    mutex.lock();
    mutex.unlock();
    p1 = leftMotor->power();
    p2 = rightMotor->power();
    
    if (p1 >= 0 && p2 >= 0)
    {
        v1 = p1 * MAX_WHEEL_TRIK_SPEED / 100;
        v2 = p2 * MAX_WHEEL_TRIK_SPEED / 100;    
    }
    else
    {
        v1 = p1 * MAX_WHEEL_TRIK_SPEED / 100;
        v2 = p2 * MAX_WHEEL_TRIK_SPEED / 100;
    }
    v = (v1 + v2) / 2;
    
    theta = pos_data.pos.pa;

    // Velocity and rotation rate are already in m/s and rad/s
    // Calculate velocity and rotation rate in global reference frame
    dx = v * cos(theta);
    dy = v * sin(theta);

    new_timestamp_ms = std::chrono::high_resolution_clock::now();
    dt = std::chrono::duration_cast<std::chrono::milliseconds>(new_timestamp_ms - timestamp_ms).count();
    timestamp_ms = new_timestamp_ms;
    //dtheta = rotationRate;

    // Calculate pose change in global reference frame
    if (!gyroThreadStarted) return;
    gyroMutex.lock();
    gyroMutex.unlock();
    delta_x = dx * dt / 1000; // ms
    delta_y = dy * dt / 1000; // ms

    delta_theta = gyroIntegrator->angle() - theta;
    theta = gyroIntegrator->angle();

    theta = NORMALIZE(theta);
    if (theta < 0)
        theta += 2 * M_PI;
    //PLAYER_MSG3(1, "dx: %f, dy: %f, da: %f", delta_x, delta_y, delta_theta);

    // Calculate actual pose in global reference frame
    pos_data.pos.px += delta_x;
    pos_data.pos.py += delta_y;
    pos_data.pos.pa = theta;

    // Report velocities
    pos_data.vel.px = dx;
    pos_data.vel.py = dy;
    pos_data.vel.pa = dtheta;
    // Robot is not stalled
    pos_data.stall = 0;

    Publish(position2d_id, PLAYER_MSGTYPE_DATA, PLAYER_POSITION2D_DATA_STATE,
            (void*)&pos_data, sizeof(pos_data), NULL);
//     PLAYER_MSG4(1, "x: %f, y: %f, yaw: %f, dt: %d", 
//         pos_data.pos.px, pos_data.pos.py, pos_data.pos.pa, dt);
}

void TrikMotors::UpdateRngData(void) {
    if (!brickThreadStarted) return;

    uint32_t ranges_count = 20;
    uint32_t intensities_count = ranges_count;
    double *ranges = new double[ranges_count];
    double *intensities = new double[intensities_count];
    double reading = (double)irSensor->read() / 100.0; // in meters
    for (int i = 0; i < ranges_count; ++i)
    {
        ranges[i] = reading;
        intensities[i] = 100;
    }
    //PLAYER_MSG1(1, "Updating data.. %f", ranges[0]);

    rng_data.ranges_count = ranges_count;
    rng_data.ranges = ranges;
    intensity_data.intensities_count = intensities_count;
    intensity_data.intensities = intensities;

    Publish(ranger_id, PLAYER_MSGTYPE_DATA, PLAYER_RANGER_DATA_RANGE,
            reinterpret_cast<void*> (&rng_data), sizeof(rng_data), NULL);

    Publish(ranger_id, PLAYER_MSGTYPE_DATA, PLAYER_RANGER_DATA_INTNS, 
            reinterpret_cast<void*> (&intensity_data), sizeof (intensity_data), NULL);
}

void TrikMotors::ProcessPos2dPosCmd(player_msghdr_t* hdr, 
                                    player_position2d_cmd_pos_t &data) { 
    // PLS: implement 
} 

void TrikMotors::ProcessPos2dVelCmd(player_msghdr_t* hdr, 
                                    player_position2d_cmd_vel_t &data) { 
    int vel;
    int rot;
    int leftM, rightM;
    float v, vl, vr;
    int direction = (data.vel.px >= 0) ? 1 : -1;

    //PLAYER_MSG3(1, "vel cmd %f, %d : %f", data.vel.px, direction, data.vel.pa);

    v = sqrt(data.vel.px * data.vel.px + data.vel.py * data.vel.py);
    vl = direction * v - TRIK_WHEEL_BASE * data.vel.pa / 2;
    vr = direction * v + TRIK_WHEEL_BASE * data.vel.pa / 2;

    if (direction == 1)
    {
        leftM  = round(vl / MAX_WHEEL_FORW_SPEED) * 100;
        rightM = round(vr / MAX_WHEEL_FORW_SPEED) * 100;
        //PLAYER_MSG2(1, "vl: %f, vr: %f", vl, vr);
        //PLAYER_MSG2(1, "m3: %d, m4: %d", leftM, rightM);
    }
    else
    {
        leftM  = round(vl / MAX_WHEEL_BACKW_SPEED) * 100;
        rightM = round(vr / MAX_WHEEL_BACKW_SPEED) * 100;
        //PLAYER_MSG2(1, "vl: %f, vr: %f", vl, vr);
        //PLAYER_MSG2(1, "m3: %d, m4: %d", leftM, rightM); 
    }

    leftMotor->setPower(leftM);
    rightMotor->setPower(rightM);
}

void TrikMotors::ProcessPos2dCarCmd(player_msghdr_t* hdr,
                                    player_position2d_cmd_car_t &data) {
    PLAYER_MSG2(1, "velocity: %f, angle: %f", data.velocity, data.angle);
}

void TrikMotors::ProcessPos2dGeomReq() { 
   player_position2d_geom_t geom; 

   geom.pose.px = pos_data.pos.px;                                        // [m] 
   geom.pose.py = pos_data.pos.py;                                        // [m] 
   geom.pose.pz = pos_data.pos.pa;                                        // [rad] 
   geom.size.sl = 0.2;                                                    // [m] 
   geom.size.sw = 0.2;                                                    // [m] 
   geom.size.sh = 0.2;                                                    // [m] 

   Publish(position2d_id,  
           PLAYER_MSGTYPE_RESP_ACK, PLAYER_POSITION2D_REQ_GET_GEOM,  
           &geom, sizeof(geom), NULL); 
}

void TrikMotors::ProcessRngGeomReq() {
    player_ranger_geom_t geom;
    player_pose3d_t elementPose;
    player_bbox3d_t elementSize;

    geom.pose.px = 0.1;
    geom.pose.py = -0.1;
    geom.pose.pz = 0.05;
    geom.pose.proll = 0.0;
    geom.pose.ppitch = 0.0;
    geom.pose.pyaw = 0.0;
    geom.size.sw = 0.03;
    geom.size.sl = 0.015;
    geom.size.sh = 0.01;
    geom.element_poses_count = 1;
    geom.element_poses = &elementPose;
    memcpy (geom.element_poses, &geom.pose, sizeof (geom.pose));
    geom.element_sizes_count = 1;
    geom.element_sizes = &elementSize;
    memcpy (geom.element_sizes, &geom.size, sizeof (geom.size));

    QApplication::processEvents();
    Publish(ranger_id, 
            PLAYER_MSGTYPE_RESP_ACK, PLAYER_RANGER_REQ_GET_GEOM,
            &geom, sizeof(geom), NULL);
}

#include "moc_trikMotors.h"