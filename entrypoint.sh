# update defaults
cat << EOF >> /etc/nginx/conf.d/default.conf
server {
    listen       80;
    server_name  _;

    location / {
      return 404;
    }
}
EOF

# create proxy configs
for dom_ip in $(echo $DOMAINS | tr ";" "\n"); do
  IFS=@ read -r domain ip_addr <<< "$dom_ip"
  cat << EOF > /etc/nginx/conf.d/"$domain".conf
server {
    listen       80;
    server_name  $domain;

    location / {
       proxy_pass $ip_addr;
    }
}
EOF
done && \
exec nginx -g 'daemon off;'


