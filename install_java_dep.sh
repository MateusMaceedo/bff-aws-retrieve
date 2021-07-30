#!/bin/sh

# installing java 8 and removing java 7
sudo yum install -y java-1.8.0-openjdk-devel
sudo alternatives --set java /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java
sudo yum remove -y java-1.7.0-openjdk-devel 
sudo yum install jq -y

# installing maven
mkdir ~/bin 
cd ~/bin 
wget -qO- ${BINARY_PATH_PREFIX}/apache-maven-3.6.3-bin.tar.gz | tar xzv -C ~/bin 
echo "export PATH=~/bin/apache-maven-3.6.3/bin:${PATH}" >> ~/.bashrc
source ~/.bashrc 

# installing docker compose
sudo curl -kLo ~/bin/docker-compose ${BINARY_PATH_PREFIX}/docker-compose-Linux-x86_64 
sudo chmod +x ~/bin/docker-compose 

# verifying if everything is properly set
java -version && \
mvn -v &&\
docker-compose -v

# entering the main directory
cd /home/ec2-user/environment/lab3task1