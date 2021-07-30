#!/bin/sh

#getting region
AWS_REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/\(.*\)[a-z]/\1/')

# setting the .env file to locally test
SECRET_NAME=$(aws secretsmanager list-secrets --query 'SecretList[?starts_with(Name, `Lab3DBInstance`) == `true`].{Name:Name}' --output text --region ${AWS_REGION})
echo DB_SECRETS=$(aws secretsmanager get-secret-value --secret-id ${SECRET_NAME} --query SecretString --output text --region $AWS_REGION) > .env

#start containers
docker-compose up