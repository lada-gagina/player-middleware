#pragma once
#include <QtCore/QDateTime>

class SuperCosmoGyroIntegrator3000 : public QObject 
{
    Q_OBJECT

public:
    SuperCosmoGyroIntegrator3000(qreal gyroAvg) 
    	: gyroAvg(gyroAvg)
    	, mAngle(0)
    	, mOldTimestamp(QDateTime::currentMSecsSinceEpoch())
    {
        //gyroAvg = gyroAvg;
        //mAngle = 0.0;
        qDebug() << gyroAvg;
    }

    qreal angle() const {
        return mAngle;
    }

public slots:
    void onNewData(const QVector<int> &reading, const trikKernel::TimeVal &eventTime) 
    {
    	quint64 time = QDateTime::currentMSecsSinceEpoch();
   		int dt = static_cast<int>(time - mOldTimestamp);
        qreal rotationRate = (reading[2] - gyroAvg) / 820826.0; // in rad/s
        qreal delta_angle = rotationRate * dt;
        mAngle += delta_angle;
        mOldTimestamp = time;
    }

private:
	quint64 mOldTimestamp;
    qreal gyroAvg;
    qreal mAngle;
};
