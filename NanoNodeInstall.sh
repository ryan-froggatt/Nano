
#Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce

#Install Nano Node
sudo docker pull nanocurrency/nano
Container=$(sudo docker run -d -p 7075:7075/udp -p 7075:7075 -p [::1]:7076:7076 -v ~:/root nanocurrency/nano)

#Configure Command Line Alias
alias rai='sudo docker exec '$Container' /usr/bin/rai_node'
