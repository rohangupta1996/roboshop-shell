echo -e "\e[31m Installing Nginx\e[0m"
yum install nginx -y

echo -e "\e[32m removing old content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[33m Downloading frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[34m Extracting Downloaded frontend\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[35m Copying nginx config\e[0m"
cp configs/nginx.roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "[\e[32m Enabling nginx \e[0m"
systemctl enable nginx

echo -e "\e[35m Start nginx\e[0m"
systemctl start nginx
