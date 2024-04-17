#!/bin/bash
INFILE=/home/gbane/Bureau/Mini-Projets/scripts-shell/list.txt
# Read the input file line by line

mkdir -p app-dir
export instance_ip=$(awk '{print $1}' src/terraform/staging/files/infos_ec2.txt)

for LINE in $(cat "$INFILE")
do
    cp -r src/"$LINE" app-dir/
done
cp src/scripts/deploy-apps.sh app-dir/ && cp src/terraform/staging/infos_ec2.txt app-dir/

zip -r app-dir.zip app-dir/

scp -i $TF_DIR/$ENV_NAME/files/$AWS_KEY_NAME.pem -o StrictHostKeyChecking=no -r app-dir.zip ubuntu@$instance_ip:~/
ssh -i $TF_DIR/$ENV_NAME/files/$AWS_KEY_NAME.pem -o StrictHostKeyChecking=no  ubuntu@$instance_ip "unzip ~/app-dir.zip"
ssh -i $TF_DIR/$ENV_NAME/files/$AWS_KEY_NAME.pem -o StrictHostKeyChecking=no  ubuntu@$instance_ip "chmod +x ~/app-dir/deploy-apps.sh"
ssh -i $TF_DIR/$ENV_NAME/files/$AWS_KEY_NAME.pem -o StrictHostKeyChecking=no  ubuntu@$instance_ip "sh ~/app-dir/deploy-apps.sh"
sleep 5
rm -rf app-dir app-dir.zip