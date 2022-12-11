Dockerfile build reference: 
https://roboticseabass.com/2021/04/21/docker-and-ros/


#Build docker: 
```
sudo docker build -f Dockerfile -t custom-nvidia-noetic-boxer-v1.0:dock-dock-go .
```
Running once built: 
#Give permissions:

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
sudo docker run --privileged -it -e DISPLAY -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v ~/:/home <DOCKER_IMAGE_ID>
```

#docker exec:
Run the following command to find the CONTAINER_ID
```
sudo docker ps 
```

use it to use enter the running docker:
```
sudo docker exec -it <CONTAINER_ID> bash
```


TODO: 
use docker compose to run docker
