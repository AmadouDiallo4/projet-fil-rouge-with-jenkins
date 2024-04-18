#!/usr/bin/env groovy
/* groovylint-disable LineLength, NglParseError */
/* groovylint-disable-next-line NglParseError */
def exportIp(dirname) {
    sh "export instance_ip=$(awk '{print $1}' src/terraform/${dirname}/files/infos_ec2.txt)"
}

def appDirname(dirname) {
    sh '''
        INFILE=$PWD/list.txt
        mkdir -p app-dir
        for LINE in $(cat "$INFILE")
        do
            cp -r src/"$LINE" app-dir/
        done
    '''
}

def copyFile(dirname) {
    sh '''
        cp src/scripts/deploy-apps.sh app-dir/ && cp src/terraform/${dirname}/files/infos_ec2.txt app-dir/
        zip -r app-dir.zip app-dir/
        scp -i $TF_DIR/${dirname}/files/$AWS_KEY_NAME.pem -o StrictHostKeyChecking=no -r app-dir.zip $username@$instance_ip:~/
    '''
}

def unzipDir(dirname) {
    sh ' ssh -i $TF_DIR/${dirname}/files/$AWS_KEY_NAME.pem -o StrictHostKeyChecking=no  $username@$instance_ip "unzip ~/app-dir.zip" '
}

def apps(dirname) {
    sh '''
        ssh -i $TF_DIR/${dirname}/files/$AWS_KEY_NAME.pem -o StrictHostKeyChecking=no  $username@$instance_ip "unzip ~/app-dir.zip"
        ssh -i $TF_DIR/${dirname}/files/$AWS_KEY_NAME.pem -o StrictHostKeyChecking=no  $username@$instance_ip "chmod +x ~/app-dir/deploy-apps.sh"
        ssh -i $TF_DIR/${dirname}/files/$AWS_KEY_NAME.pem -o StrictHostKeyChecking=no  $username@$instance_ip "cd ~/app-dir && sh deploy-apps.sh"
    '''
}

def deleteDirs(dirname) {
    sh "rm -rf ~/app-dir ~/app-dir.zip"
}
