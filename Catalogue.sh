source common.sh

print_head "Configure nodeJS Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$(log_file)
status_check $?

print_head "Install NodeJS"
yum install nodejs -y &>>$(log_file)
status_check $?

print_head "Create roboshop user"
useradd roboshop &>>$(log_file)
status_check $?

print_head "create application directory"
mkdir /app &>>$(log_file)
status_check $?

print_head "delete old content "
rm -rf /app/* &>>$(log_file)
status_check $?

print_head "Downloading App Content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>$(log_file)
status_check $?
cd /app

print_head "Extracting app content"
unzip /tmp/catalogue.zip &>>$(log_file)
status_check $?

print_head "Install NodeJS Dependencies"
npm install &>>$(log_file)
status_check $?

print_head "Copy SystemD Service file"
cp $(code_dir)/configs/catalogue.service /etc/systemd/system/catalogue.service &>>$(log_file)
status_check $?

print_head "Reload SystemD"
systemctl daemon-reload &>>$(log_file)
status_check $?

print_head "Enable catalogue"
systemctl enable catalogue &>>$(log_file)
status_check $?

print_head "Start Catalogue Service"
systemctl start catalogue &>>$(log_file)
status_check $?

print_head "Copy MongoDB Repo File"
cp configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>$(log_file)
status_check $?

print_head " Install MongoDB Client"
yum install mongodb-org-shell -y &>>$(log_file)
status_check $?

print_head "Load- schema"
mongo --host mongodb.rohandevops.online </app/schema/catalogue.js &>>$(log_file)
status_check $?
