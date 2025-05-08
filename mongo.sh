source common.sh

print_head Copy mongoDB repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $log_file

print_head Install MongoDB
dnf install mongodb-org -y

print_head Update mongoDB Config file
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

print_head Start MongoDB service
systemctl enable mongod &>> $log_file
systemctl restart mongod &>> $log_file