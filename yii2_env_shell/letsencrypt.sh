# 下载 Certbot 客户端
cd /usr/local/bin
wget https://dl.eff.org/certbot-auto

# 设为可执行权限
chmod a+x certbot-auto

./certbot-auto certonly  -d "*.xxx.com" --manual --preferred-challenges dns-01  --server https://acme-v02.api.letsencrypt.org/directory


server {
    listen 80; 
    listen [::]:80;
    server_name example.com www.example.com;
    return 301 https://$host$request_uri;
}

# config example
listen 443 http2 ssl;
ssl_certificate /etc/letsencrypt/live/xxx.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/xxx.com/privkey.pem;
ssl_trusted_certificate  /etc/letsencrypt/live/xxx.com/chain.pem;


# 15 2 * */2 * certbot-auto renew --pre-hook "service nginx stop" --post-hook "service nginx start"
