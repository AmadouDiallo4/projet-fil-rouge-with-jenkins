#!bin/bash
export instance_ip=$(curl https://checkip.amazonaws.com)
#cd app-dir/
version=$(awk 'NR==3 {print $2}' releases.txt) docker-compose up -d --build
pwd
ls -ltrh
sleep 10
docker ps -a
