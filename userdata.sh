#!/bin/bash
apt-get update -y
apt-get upgrade -y
apt-get install git -y
apt install unzip
apt-get install python3 -y
apt install python3-pip -y
pip3 install boto3
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
cd /home/ubuntu/
TOKEN=$(aws --region=us-east-1 ssm get-parameter --name /hasan/capstone/token --with-decryption --query 'Parameter.Value' --output text)
# (private repo) --> git clone https://$TOKEN@github.com/Morgoliath/aws-capstone.git
git clone https://github.com/hasanyurt35/capstone.git
cd /home/ubuntu/capstone
apt-get install python3.10-dev default-libmysqlclient-dev -y
pip3 install -r requirements.txt
cd /home/ubuntu/capstone/src
python3 manage.py collectstatic --noinput
python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py runserver 0.0.0.0:80
