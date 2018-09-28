# CodeScene on Docker

This repository is an example of how to run CodeScene in a Docker
instance behind an nginx reverse proxy. Even if you are not using Docker, the
nginx configuration may be helpful for running CodeScene behind nginx. 

`docker-compose` is used here to run two Docker images, one running
nginx, the other with CodeScene itself. The [CodeScene
Dockerfile](docker-codescene/Dockerfile) can also be used by itself to
run CodeScene directly.

## Install

This assumes that you have a working Docker installation.

Clone this repository and go to the top level directory.

    git clone git@github.com:empear-analytics/docker-codescene-nginx-self-signed-ssl.git
	cd docker-codescene-nginx-self-signed-sll

## Build

The reverse proxy using Nginx is built like this:

    docker build -t reverseproxy docker-nginx/

The CodeScene image should already be available from [Docker Hub](https://hub.docker.com/r/empear/ubuntu-onprem/) under
`empear/ubuntu-onprem:latest`, but can also be built locally like this (specify a proper CodeScene version):

    docker build --build-arg CODESCENE_VERSION=2.X.Y -t empear/ubuntu-onprem docker-codescene/

## Run

To run CodeScene behind the reverse proxy, use `docker-compose` to start both instances:

    docker-compose up -d
	
To run CodeScene by itself, without the reverse proxy:

	docker pull empear/ubuntu-onprem
	docker run -i -t -p 3003 --name myname empear/ubuntu-onprem
	
To connect to this instance:

    docker exec -i -t myname /bin/bash

### Stop

To stop the reverse proxy:

    docker-compose down
	

#### Memory settings

To adjust memory settings for CodeScene running inside a container, 
you can set the `JAVA_OPTIONS` environment variable.

To set "max heap" explicitly use `-Xmx`:

```
# with explicit max memory => notice that -m 500M is ignored
docker run -p3103:3003 -m 500M -e JAVA_OPTIONS='-Xmx300m' --name codescene empear/ubuntu-onprem
VM settings:
    Max. Heap Size: 300.00M
    Ergonomics Machine Class: server
    Using VM: OpenJDK 64-Bit Server VM
```

To let the JVM autodetect default settings based on the container's memory:

```
# with experimental options and autodetection
# note that -XX:+UseCGroupMemoryLimitForHeap has been deprecated 
docker run -p3103:3003 -m 500M -e JAVA_OPTIONS='-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=2' --name codescene empear/ubuntu-onprem
VM settings:
    Max. Heap Size (Estimated): 222.50M
    Ergonomics Machine Class: server
    Using VM: OpenJDK 64-Bit Server VM
```

Please note, that 
[support for `-XX:+UseCGroupMemoryLimitForHeap` has been deprecated in JDK 10](https://bugs.openjdk.java.net/browse/JDK-8194086)
and is no longer needed.

For more details, see 
[Java inside docker: What you must know to not FAIL](https://developers.redhat.com/blog/2017/03/14/java-inside-docker/).


### Use

Browse to https://localhost. In order to use CodeScene, you will need a
license. You can get a license on the [Empear Customer Portal](https://portal.empear.com/).
For more information about CodeScene, see the [CodeScene Documentation](https://docs.enterprise.codescene.io/).

When creating projects, you can use the `/repos` directory to store Git repositories, and the `/analysis` directory for your analysis results ("Analysis Results Destination").

### Stop

    docker-compose down

### License, Liability & Support

* The contents of this repository are provided under the [MIT License](https://github.com/empear-analytics/docker-codescene-nginx-self-signed-ssl/blob/master/LICENSE.md). Other licences may apply to the software contained in the Docker images referenced here.


### Analyze this this project on CodeScene

[![](https://codescene.io/projects/2554/status.svg) Get more details at **codescene.io**.](https://codescene.io/projects/2554/jobs/latest-successful/results)
