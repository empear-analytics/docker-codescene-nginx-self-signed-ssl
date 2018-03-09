### Build

The reverse proxy using Nginx is built like this:

    docker build -t reverseproxy docker-nginx/

The CodeScene image should already be available from [Docker Hub](https://hub.docker.com/r/empear/debian-onprem/) under
`empear/debian-onprem:latest`, but can also be built locally like this:

    docker build -t empear/debian-onprem docker-codescene/

### Run

    docker-compose up -d

### Use

Browse to https://localhost. In order to use CodeScene, you will need a
license. You can get a license on the [Empear Customer Portal](https://portal.empear.com/).
For more information about CodeScene, see the [CodeScene Documentation](https://docs.enterprise.codescene.io/).

### Stop

    docker-compose down

### License, Liability & Support

 * Dockerfile and Image is provided under [MIT License](https://github.com/empear-analytics/docker-codescene-nginx-self-signed-ssl/blob/master/LICENSE.md)
