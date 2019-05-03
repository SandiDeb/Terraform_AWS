# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done
# install nginx
sudo yum update -y
sudo yum install nginx -y
# make sure nginx is started
sudo service nginx start

systemctl start firewalld

# Open firewall port 8080
firewall-cmd --add-port="8080/tcp" --permanent

systemctl restart firewalld
