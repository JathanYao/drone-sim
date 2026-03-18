# drone-sim

## how to run:

In the `drone_sim` directory, run:

```bash
docker run -it --rm \
  --net=host \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "$(pwd):/home/user/drone-sim" \
  drone-sim
```

Navigate to PX4-autopilot directory, run make px4_sitl gz_x500 (or gz_x500_baylands for terrain):

```bash
cd PX4-autopilot
make px4_sitl gz_x500
```

Open a new terminal, run the following command and store this address:

```bash
hostname -I
```

Go back to the terminal running gazebo and run:

```bash
mavlink stop-all
mavlink start -u 14550 -t <IP ADDRESS>
```

Open a new terminal, run:

```bash
./QGroundControl-x86_64.AppImage &
```
