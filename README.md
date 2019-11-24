## About
Simple dockerized request router using NGINX

## Design
This docker image is designed to use locally mounted volumes (e.g. the -v option seen in the below
tutorials) to mount *.conf files for both the NGINX server and any subsequent servers you want to
configure NGINX to route requests to.

## Example Web Server Config File
Below is an example of how to write a small *.conf file for each server you want to route requests
to:

```
$ cat server.conf
server {
    listen       80;
    server_name  ${DOMAIN_NAME};

    location / {
        proxy_pass ${ADDRESS}:${PORT};
    }
}
```
The above variables can be replaced with the following values:
```
DOMAIN_NAME=example.com
ADDRESS=http://127.0.0.1
PORT=8080
```
This would create a config file as follows:
```
server {
    listen       80;
    server_name  example.com;

    location / {
        proxy_pass http://127.0.0.1:8080;
    }
}
```
Simply save this file in the `config/conf.d` directory and NGINX will find this when you run the 
container as depicted using the `-v` flag below.

## Docker Build
```
 # navigate to github repo directory
 cd request-router

 # build docker image
 docker build -t request-router .
```

## Docker Create
```
 # create the container first
 docker create --name=request-router \
               -v $PWD/config/nginx.conf:/etc/nginx/nginx.conf \
               -v $PWD/config/conf.d/:/etc/nginx/conf.d/ \
               -p 80:80 \
               request-router

 # run the container as follows
 docker start request-router
```

## Docker Run
```
 # run docker container in daemon mode (i.e. -d option)
 docker run -d \
            --name=request-router \
            -v $PWD/config/nginx.conf:/etc/nginx/nginx.conf \
            -v $PWD/config/conf.d/:/etc/nginx/conf.d/ \
            -p 80:80 \
            request-router
```
