# k3s-docker

- Install k3s on docker

To build the Docker image and run the container, simply execute:
```sh
make
```
To access the running container:
```sh
make exec
```
To stop and remove the container:
```sh
make stop
```
To clean up (remove the container and the image):
```sh
make clean
```