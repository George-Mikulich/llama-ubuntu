sudo apt-get update
sudo apt-get install certbot --assume-yes
sudo apt-get install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt-get update
sudo apt-get install caddy --assume-yes
sudo certbot certonly --standalone -d llama.st-demo.com
sudo cat <<EOF > /etc/caddy/Caddyfile
:80 {
        redir https://{host}{uri}
}
:443 {
        tls /etc/letsencrypt/live/llama.st-demo.com/fullchain.pem /etc/letsencrypt/live/llama.st-demo.com/privkey.pem
        reverse_proxy localhost:8080
        log {
                output file /var/log/caddy/access.log
        }
}
EOF