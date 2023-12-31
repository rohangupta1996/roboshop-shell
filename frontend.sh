source common.sh

print_head "Installing Nginx"
yum install nginx -y &>>$(log_file)
status_check $?

print_head "removing old content"
rm -rf /usr/share/nginx/html/* &>>$(log_file)
status_check $?

print_head "Downloading frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>$(log_file)
status_check $?

print_head "Extracting Downloaded frontend"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$(log_file)
status_check $?

print_head "Copying nginx config"
cp $(code_dir)/configs/nginx.roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$(log_file)
status_check $?

print_head "Enabling nginx"
systemctl enable nginx
status_check $?

print_head "Start nginx"
systemctl start nginx
status_check $?
