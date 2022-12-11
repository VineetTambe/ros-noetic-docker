FROM nvidia/cudagl:11.4.2-base-ubuntu20.04

# RUN apt update && apt upgrade -y
RUN apt-get update \
 && apt-get install -y locales lsb-release
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure locales
RUN apt install apt-utils -y

# Install ros-noetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update && apt-get install build-essential -y
RUN apt install ~nros-noetic-rqt* -y
RUN apt-get install -y --no-install-recommends python3-rosdep
RUN rosdep init \
 && rosdep fix-permissions \
 && rosdep update
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Install helper ros tools
RUN apt install python3-catkin-tools -y
RUN apt install rviz -y

# Change the default shell to Bash
SHELL [ "/bin/bash" , "-c" ]
 
# Install Git
RUN apt-get update && apt-get install -y git

# Create a Catkin workspace and clone TurtleBot3 repos
RUN source /opt/ros/noetic/setup.bash \
 && mkdir -p /clearpath_boxer_ws/src \
 && cd /clearpath_boxer_ws/ \
 && catkin_init_workspace \
 && cd ./src \
 && git clone https://github.com/boxer-cpr/boxer.git \
 && git clone https://github.com/boxer-cpr/boxer_desktop.git \
 && git clone https://github.com/boxer-cpr/boxer_simulation.git \
 && git clone https://github.com/boxer-cpr/boxer_robot.git \
 && git clone https://github.com/boxer-cpr/boxer_manipulation.git \
 && rosdep install --from-paths ../src --ignore-src --rosdistro=noetic -r -y

# Build the Catkin workspace and ensure it's sourced
RUN source /opt/ros/noetic/setup.bash \
 && cd clearpath_boxer_ws \
 && catkin build
RUN echo "source /clearpath_boxer_ws/devel/setup.bash" >> ~/.bashrc
 
# Set the working folder at startup
WORKDIR /clearpath_boxer_ws

LABEL version="1.0"
LABEL description="A nvidia-ROS image with noetic-desktop-full, all tools and boxer sim installed"

# nvidia-docker hooks
# LABEL com.nvidia.volumes.needed="nvidia_driver"
# ENV PATH /usr/local/nvidia/bin:${PATH}
# ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}
