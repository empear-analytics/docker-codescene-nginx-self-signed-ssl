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
`empear/ubuntu-onprem:latest`, but can also be built locally like this:

    docker build -t empear/ubuntu-onprem docker-codescene/

If you want to use a specific version of CodeScene, you can add a `--build-arg`:

    docker build  --build-arg CODESCENE_VERSION=3.X.Y -t empear/ubuntu-onprem docker-codescene/
	
## Run

### Run CodeScene behind the reverse proxy

Use `docker-compose` to start both instances:

    docker-compose up -d
    
### Run CodeScene by itself without the reverse proxy:

    docker pull empear/ubuntu-onprem
    docker run -i -t -p 3003 \
        --name myname \
        --mount type=bind,source=$(PWD)/docker-codescene/codescene,destination=/codescene \
        empear/ubuntu-onprem
    
To connect to this instance:

    docker exec -i -t myname /bin/bash


### Bind mount and/or Docker volume

In both the reverse proxy setup and the standalone version, the
`/codescene` directory is bound to local the
[`docker-codescene/codescene`](docker-codescene/codescene) directory
in this repository. It contains two directories, `repos` and
`analyses` that can be used to store Git repositories and the analysis
result files that CodeScene produces. CodeScene's internal database is
also stored in `/codescene`, as well as a logfile. By using these directories, your data
will be persisted beyond the life of the Docker container.

The configuration presented here uses CodeScene's optional environment
variables `CODESCENE_ANALYSIS_RESULTS_ROOT` and
`CODESCENE_CLOSED_REPOSITORIES_ROOT` (available as of CodeScene
v2.8.1). Their purpose is to ensure that users cannot create
repositories or store analysis results outside of the `/codescene`
directory. In conjunction with the `CODESCENE_DB_PATH`, we can be sure
that all the necessary data for persisting CodeScene is in a single,
easy-to-manage location. You can of course adjust these variables to
fit your specific needs.

This configuration is intended for demonstration and debugging. In a
production setting, [Docker volumes](https://docs.docker.com/storage/volumes) would be a better
solution.

These options are configured in [`docker-compose.yml`](docker-compose.yml) for the reverse
proxy setup, and in the command-line arguments for the standalone
version (see [Run CodeScene by itself without the reverse proxy](#run-codescene-by-itself-without-the-reverse-proxy)).

### Memory settings

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
docker run -p3103:3003 -m 500M -e \
    JAVA_OPTIONS='-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=2' \
    --mount type=bind,source=$PWD/docker-codescene/codescene,destination=/codescene \
    --name codescene empear/ubuntu-onprem 
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

### Stop

To stop the reverse proxy:

    docker-compose down


### License, Liability & Support

* The contents of this repository are provided under the [MIT License](https://github.com/empear-analytics/docker-codescene-nginx-self-signed-ssl/blob/master/LICENSE.md). Other licences may apply to the software contained in the Docker images referenced here.


### Analyze this this project on CodeScene

[![](https://codescene.io/projects/2554/status.svg) Get more details at **codescene.io**.](https://codescene.io/projects/2554/jobs/latest-successful/results)
