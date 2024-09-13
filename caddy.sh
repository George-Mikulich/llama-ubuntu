sudo apt-get update
sudo apt-get install certbot
sudo apt-get install caddy
sudo certbot certonly --standalone -d <domain>
sudo cat <<EOF > /etc/caddy/caddyfile
:443 {
       tls /etc/letsencrypt/live/<domain>/fullchain.pem /etc/letsencrypt/live/<domain>/privkey.pem
       reverse_proxy localhost:8080
       log {
           output file /var/log/caddy/access.log
       }
   }
EOF