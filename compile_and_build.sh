#!/bin/sh

#getting region
AWS_REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/\(.*\)[a-z]/\1/')

# setting the .env file to locally test
SECRET_NAME=$(aws secretsmanager list-secrets --query 'SecretList[?starts_with(Name, `Lab3DBInstance`) == `true`].{Name:Name}' --output text --region ${AWS_REGION})
echo DB_SECRETS=$(aws secretsmanager get-secret-value --secret-id ${SECRET_NAME} --query SecretString --output text --region $AWS_REGION) > .env

source ~/.bashrc 

#build create-products
cd ./backend-create-products
mvn -o clean package
docker build -t dev-essentials/lab3/backend-create-products .

#build retrieve-products
cd ..
cd ./backend-retrieve-products
mvn -o clean package 
docker build -t dev-essentials/lab3/backend-retrieve-products .

#build frontend-ui-products
cd ..
cd ./frontend-ui-products
mvn -o clean package
docker build -t dev-essentials/lab3/frontend-ui-products .

cd ..
docker images | grep dev-essentials
