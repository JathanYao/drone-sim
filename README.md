# 🚁 PX4 & Gazebo Simulation Environment (WSL2 + Docker)

This repository contains the setup and launch instructions for running the PX4 Autopilot and Gazebo Harmonic drone simulation seamlessly using Docker and native Linux applications.

---

## 🚀 Quick Start Guide

You will need three separate terminal windows to run this environment effectively.

### Step 1: Start the Docker Environment

Open **Terminal 1** in your `drone-sim` directory and start the Docker container with graphics and host networking enabled:

```bash
docker run -it --rm \
    --net=host \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "$(pwd):/home/user/drone-sim" \
    drone-sim
Step 2: Launch the Simulator
Staying in Terminal 1 (inside the Docker container), navigate to the PX4 source code and build the simulator:

Bash
cd PX4-Autopilot

# Launch the default empty world:
make px4_sitl gz_x500

# OR launch a custom terrain (e.g., Baylands) for a better visual environment:
# make px4_sitl gz_x500_baylands
(Wait a moment for Gazebo to fully load and for the terminal to display the pxh> prompt).

Step 3: Route the Network (WSL2/Docker Fix)
Because Docker and WSL2 can sometimes isolate UDP traffic, we need to explicitly point the drone's telemetry out to your local machine's internal IP.

Open Terminal 2 (a standard WSL Ubuntu terminal) and find your WSL IP address:

Bash
hostname -I
(Copy the very first IP address that appears, e.g., 172.x.x.x).

Go back to Terminal 1 (the Gazebo/PX4 terminal where the pxh> prompt is) and run:

Bash
mavlink stop-all
mavlink start -u 14550 -t <YOUR_IP_ADDRESS>
(Replace <YOUR_IP_ADDRESS> with the IP you copied).

Step 4: Launch QGroundControl
Open Terminal 3 (a standard WSL Ubuntu terminal) and launch the native Linux Ground Control Station in the background:

Bash
./QGroundControl-x86_64.AppImage &
QGroundControl should now automatically connect to the simulator, download parameters, and display the green Ready To Fly status at the top!
```
