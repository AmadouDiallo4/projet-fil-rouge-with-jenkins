# install terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform -y

# install ansible
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y 
sudo apt install ansible -y

# docker 
sudo apt install -y curl git,
curl -fsSL https://get.docker.com -o get-docker.sh,
sudo sh get-docker.sh,
sudo usermod -aG docker $USER,
sudo systemctl enable docker,
sudo systemctl start docker,
sudo curl -L https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-$(uname -s)-$(uname -m) -o /usr/bin/docker-compose,
sudo chmod +x /usr/bin/docker-compose,
sudo docker version,
sudo docker-compose version
