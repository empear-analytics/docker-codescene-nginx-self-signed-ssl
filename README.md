This repository is an example of how to run CodeScene in a Docker
instance behind an nginx reverse proxy. Even if you are not using Docker, the
nginx configuration may be helpful for running CodeScene behind nginx. 

`docker-compose` is used here to run two Docker images, one running
nginx, the other with CodeScene itself. The [CodeScene
Dockerfile](docker-codescene/Dockerfile) can also be used by itself to
run CodeScene directly.

### Build

The reverse proxy using Nginx is built like this:

    docker build -t reverseproxy docker-nginx/

The CodeScene image should already be available from [Docker Hub](https://hub.docker.com/r/empear/debian-onprem/) under
`empear/debian-onprem:latest`, but can also be built locally like this (specify a proper CodeScene version):

    docker build --build-arg CODESCENE_VERSION=2.X.Y -t empear/debian-onprem docker-codescene/

### Run


To run CodeScene behind the reverse proxy, use `docker-compose` to start both instances:

    docker-compose up -d
	
To run CodeScene by itself, without the reverse proxy:

	docker run empear/debian-onprem
	docker run -p 3003 --name myname empear/debian-onprem

### Use

Browse to https://localhost. In order to use CodeScene, you will need a
license. You can get a license on the [Empear Customer Portal](https://portal.empear.com/).
For more information about CodeScene, see the [CodeScene Documentation](https://docs.enterprise.codescene.io/).

### Stop

    docker-compose down

### License, Liability & Support

* The contents of this repository are provided under the [MIT License](https://github.com/empear-analytics/docker-codescene-nginx-self-signed-ssl/blob/master/LICENSE.md). Other licences may apply to the software contained in the Docker images referenced here.


### Analyze this this project on CodeScene

[![](https://codescene.io/projects/2554/status.svg) Get more details at **codescene.io**.](https://codescene.io/projects/2554/jobs/latest-successful/results)
