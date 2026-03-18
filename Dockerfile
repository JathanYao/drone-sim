# Use the official ROS 2 Humble desktop image as our base
FROM osrf/ros:humble-desktop

# Install core tools, add the official Gazebo repository, and install Gazebo Harmonic
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    wget \
    gnupg \
    lsb-release \
    python3-pip \
    nano \
    sudo \
    && wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/gazebo-stable.list \
    && apt-get update \
    && apt-get install -y \
    gz-harmonic \
    protobuf-compiler \
    libprotobuf-dev \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies needed for PX4, ROS 2 message generation, and MAVSDK
RUN pip3 install --no-cache-dir \
    empy==3.3.4 \
    pyros-genmsg \
    kconfiglib \
    jsonschema \
    jinja2 \
    pyserial \
    pyyaml \
    MAVSDK \
    setuptools==58.2.0

# Clone, build, and install the Micro-XRCE-DDS-Agent
RUN git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git /opt/Micro-XRCE-DDS-Agent \
    && cd /opt/Micro-XRCE-DDS-Agent \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && ldconfig /usr/local/lib/

# Set up our working directory inside the container
WORKDIR /home/user/drone-sim

# Tell the container to always source ROS 2 when it boots up
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

# Default command when the container starts
CMD ["bash"]