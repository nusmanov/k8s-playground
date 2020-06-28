# Node JS App
Create a new directory where all the files would live. 
## NodeJS App
Starts up an HTTP server on port 8080.
Responnds with status code 200 and the text "You've hit HOSTNAME".
The request handler logs the client's IP address to standard output.
!! You don't need install Node.js locally and test the app locally.
let us use Docker to package the app int a container image and enablte it to be run anywhere (whithout downlaoding anything except Docker)  !!
```
const http = require('http');
const os = require('os');

console.log("Kubia/NodeJS server starting");

var handler = function(request, response) {
  console.log("Received request from " + request.connection.remoteAddress);
  response.writeHead(200);
  response.end("You've hit " + os.hostname() + "\n");
}

var server = http.createServer(handler);
server.listen(8080);
```
## Docker
Package your app into an image.
### Docker - Dockerfile
``` touch Dockerfile ```

```
FROM node:12

# add from local file into the root dir in the image
ADD app.js /app.js

# this command will be executed when somebody runs the image 
ENTRYPOINT [ "node", "app.js" ]
```

### Docker - build container image
Telling Docker to build  an image called `kubia` basde contents of the current directory (note the dot at the end).
Docker will look for _Dockerfile_ in the directory and build the image based on instructions in the file.
* -t flag lets you tag your image so it's easier to find later using the docker images command

```
docker build -t kubia .
```
### Docker - run the app
* run a new container called `kubia-container` from the  _kubia_ image
* the container will be detached from console (-d flag), which means it runs in background
* port 8080 will be mapped to port 8080 inside the container (-p 8080:8080 option)
* access through `http://localhost:8080`
```
docker run --name kubia-container -p 8080:8080 -d kubia
```
* the hostname as a hexadecimal number is the *hostname* (and *ID*) of the running docker container.

### Docker - list all running containers
```
docker ps
```
### Docker - additional information
Long additional information as JSON containing low level information about the container.
```
docker inspect kubia-container
```

# TODO add 2.1.6 explore the inside of the running container
```
docker exec -it kubia-container bash
```
### Docker - stop
Stops the main process running in the container and consequently stop the conatiner.
The container itself exists: `docker ps -a`
```
docker stop kubia-container
```
Remove the container
```
docker rm kubia-container
```

# k3d - k3s as docker

k3d create --name="mydemo" --workers="2" --publish="80:80"
k3d get kubeconfig mydemo --switch
kubectl get nodes

k3d stop --name=mydemo


## kubectl
kubectl config view

# deploy
kubectl run kubia --image=kubia --port=8080 --generator=run/v1
kubectl expose rc kubia --type=LoadBalancer --name kubia-http


# stackoverflow

k3d create cluster mydemocluster --workers="2" --publish="80:80"

--k3d get kubeconfig mydemocluster --switch
export KUBECONFIG="$(k3d get-kubeconfig --name='mydemocluster')"

kubectl run kubia --image=hello-world --port=8080 --generator=run/v1
kubectl expose rc kubia --type=LoadBalancer --name kubia-http

export KUBECONFIG="$(k3d get-kubeconfig --name='mydemocluster')"

--- 3


---
curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | TAG=v3.0.0-rc.6 bash
v3.0.0-rc.6


# Create a Cluster
## info "Cluster Name: demo"
## info "--api-port 6550: expose the Kubernetes API on localhost:6550 (via loadbalancer)"
## info "--masters 1: create 1 master node"
## info "--workers 3: create 3 worker nodes"
## info "--port 8080:80@loadbalancer: map localhost:8080 to port 80 on the loadbalancer (used for ingress)"
## info "--volume /tmp/src:/src@all: mount the local directory /tmp/src to /src in all nodes (used for code)"
## info "--wait: wait for all master nodes to be up before returning"

`k3d create cluster democluster --api-port 6550 --masters 1 --workers 3 --port 8080:80@loadbalancer`

# Update the default kubeconfig with the new cluster details
`k3d get kubeconfig democluster --update --switch`

# Use kubectl to checkout the nodes
`kubectl get nodes`


kubectl run kubia --image=kubia --port=8080 --generator=run-pod/v1
kubectl expose rc kubia --type=LoadBalancer --name kubia-http


k3d create cluster democluster --api-port 6550 --masters 1 --workers 3 --port 8080:80@loadbalancer --volume /Users/nodirbekusmanov/workspace/k8s-playground/registries.yaml:/etc/rancher/k3s/registries.yaml --volume /Users/nodirbekusmanov/workspace/k8s-playground/ZscalerRootCA.cer:/etc/ssl/certs/ZscalerRootCA.cer