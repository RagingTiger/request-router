# Base NGINX image (with alpine 3.9)
FROM nginx:1.15.8-alpine

# Get BASH and delete default.conf
RUN apk add --no-cache \
    bash && \
    rm /etc/nginx/conf.d/default.conf

# get files
COPY config/ /etc/nginx/
COPY entrypoint.sh /

# set work dir
WORKDIR /

# set new entrypoint.sh
CMD ["/bin/bash", "entrypoint.sh"]

