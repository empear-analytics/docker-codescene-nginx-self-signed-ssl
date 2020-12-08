<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Overview](#overview)
- [Install](#install)
  - [Generate a self-signed certificate](#generate-a-self-signed-certificate)
  - [Provide a custom SSL certificate](#provide-a-custom-ssl-certificate)
  - [Path prefix](#path-prefix)
- [Run](#run)
  - [Run CodeScene behind the reverse proxy](#run-codescene-behind-the-reverse-proxy)
  - [Use](#use)
  - [Stop](#stop)
- [License, Liability & Support](#license-liability--support)
- [Analyze this this project on CodeScene](#analyze-this-this-project-on-codescene)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Overview

This repository is an example of how to run CodeScene in a Docker
instance behind an nginx reverse proxy. Even if you are not using Docker, the
nginx configuration may be helpful for running CodeScene behind nginx. 

`docker-compose` is used here to run two Docker containers, one running
nginx, the other with CodeScene itself. The [CodeScene
docker image](https://hub.docker.com/r/empear/codescene) can also be used by itself to
run CodeScene directly.

# Install

This assumes that you have a working Docker installation.

Clone this repository and go to the top level directory.

    git clone git@github.com:empear-analytics/docker-codescene-nginx-self-signed-ssl.git
    cd docker-codescene-nginx-self-signed-ssl

To use it you have to either generate a self-signed certificate, or provide a real certificate.

## Generate a self-signed certificate

Generate a self-signed certificate  in the `nginx/conf.d` folder with a command like
```
openssl req -subj '/CN=localhost' -x509 -newkey rsa:4096 -nodes \
    -keyout nginx/conf.d/mycert.key \
    -out nginx/conf.d/mycert.crt -days 365
```


## Provide a custom SSL certificate
Place the ssl certificate and private key files in the *nginx/conf.d* folder to make them accessible in the nginx container.
Update the *nginx/conf.d/reverseproxy.conf* file with `ssl_certificate` and `ssl_certificate_key` set to your certificate and key file names, and with  `server_name` set to match your certificate.

## Path prefix

In some situations, it may be necessary to run CodeScene under a path
rather than at the root, eg. `example.com/codescene` rather than
simply `example.com`.

To do this, you can use the `CODESCENE_PATH_PREFIX` environment variable. The prefix you add
there will be appended to all internal links in CodeScene.

If you were to use this solution in conjunction with nginx, your [nginx.conf](docker-nginx/nginx.conf) file might include something like this:

```
location /codescene {
  return 302 /codescene/;
}
  
location /codescene/  {
  proxy_pass http://codescene:3003/;
  proxy_redirect http:// $scheme://$http_host/codescene;
}  
 ```

# Run

## Run CodeScene behind the reverse proxy

Use `docker-compose` to start both instances:

    docker-compose up -d



## Use

Browse to https://localhost. In order to use CodeScene, you will need a
license. You can get a license on the [Empear Customer Portal](https://portal.empear.com/).
For more information about CodeScene, see the [CodeScene Documentation](https://docs.enterprise.codescene.io/).

## Stop

To stop the reverse proxy:

    docker-compose down


# License, Liability & Support

* The contents of this repository are provided under the [MIT License](https://github.com/empear-analytics/docker-codescene-nginx-self-signed-ssl/blob/master/LICENSE.md). Other licences may apply to the software contained in the Docker images referenced here.


# Analyze this this project on CodeScene

[![](https://codescene.io/projects/2554/status.svg) Get more details at **codescene.io**.](https://codescene.io/projects/2554/jobs/latest-successful/results)
