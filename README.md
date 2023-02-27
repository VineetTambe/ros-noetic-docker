Dockerfile build reference: 
https://roboticseabass.com/2021/04/21/docker-and-ros/


#Build docker: 
```
sudo docker build -f Dockerfile -t custom-nvidia-noetic-v1.0:MRSD-S2023 .
```
Running once built: 
#Give permissions:
(This command will allow the docker to use your system GUI for - ex. launching rqt)
```
xhost +
```

#docker run:
get image id from:
```
sudo docker images
```

use it to run:
```
sudo docker run --privileged -it -e DISPLAY -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v ~/:/home DOCKER_IMAGE_ID
```

#docker exec:
Run the following command to find the CONTAINER_ID
```
sudo docker ps 
```

Exec will help you enter the same running docker from a different terminal.
use it to use enter the running docker:
```
sudo docker exec -it CONTAINER_ID bash
```

After you enter the docker - the docker by default will mount your /home folder
```
cd /home
```
So you can now move to where you want and use it as you would use your normal system.

TODO: 
use docker compose to run docker
