// Lada Gagina

#include <iostream>
#include <libplayerc++/playerc++.h>

int main(int argc, char *argv[])
{
  using namespace PlayerCc;

  try
  {
    PlayerClient robot("localhost");
    CameraProxy  cp(&robot, 0);

    for (uint i = 0; i < 10; ++i)
    {
      robot.Read();
      cp.SaveFrame("camera");
      // print camera
      std::cout << cp << std::endl;
    }
  }
  catch (PlayerCc::PlayerError e)
  {
    std::cerr << e << std::endl;
    return -1;
  }
  
  return 1;
}

