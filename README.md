Dockerfile build reference: 
https://roboticseabass.com/2021/04/21/docker-and-ros/


#Build docker: 
sudo docker build -f Dockerfile -t custom-nvidia-noetic-boxer-v1.0:dock-dock-go .



Running once built: 
#Give permissions:

xhost +

#docker run:

sudo docker run --privileged -it -e DISPLAY -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v ~/:/home 4dab6d5521e2

#docker exec:
#run sudo docker ps and find the CONTAINER_ID

sudo docker exec -it <CONTAINER_ID> bash



TODO: 
use docker compose to run docker
