#!/bin/bash -xe

sudo yum update -y
sudo yum upgrade -y
sudo yum install -y git
sudo yum install -y docker
sudo usermod -a -G docker ec2-user
sudo service docker start
sudo chkconfig docker on
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo yum install nginx -y
sudo service enable nginx
sudo systemctl start nginx
sudo mkdir /etc/nginx/sites-available
sudo touch /etc/nginx/sites-available/honor_api.conf
echo "server {
  listen 80 default_server;
  location / {
    proxy_pass http://localhost:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host \$host;
    proxy_cache_bypass \$http_upgrade;
  }
}" | sudo tee /etc/nginx/sites-available/honor_api.conf > /dev/null
sudo ln -s /etc/nginx/sites-available/honor_api.conf /etc/nginx/conf.d/
sudo systemctl restart nginx
git clone https://github.com/mactunechy/hono-api.git
cd hono-api
newgrp docker
POSTGRES_USER=${POSTGRES_USER}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
POSTGRES_DB=${POSTGRES_DB}
POSTGRES_HOST=${POSTGRES_HOST}
docker-compose up -d
docker-compose exec api npx prisma migrate deploy
docker-compose exec api npm run seed
