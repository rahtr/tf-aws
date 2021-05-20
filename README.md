#Set up the EBS with RDS using Spring Boot App


## Installation

Install dependencies using:

    docker-compose build


## Running locally
Ensure that the docker engine is running

Run backend and database together using:

    docker-compose up

Access the API using the following URL-->

    http://localhost:5000/

## Build the application

Build the application using the following commands

    docker-compose up db
    mvn clean package spring-boot:repackage

The compiled jar file would be generated at the following location:

    ./target/secret-message-api-0.0.1-SNAPSHOT.jar

## Running tf scrtipt

Navigate to the `tf_scripts` folder and fill in the details in `terraform.tfvars` file


Now execute the following commands:

    terraform init
    terraform plan
    terraform apply

This will create the EBS cluster with all the required resources. 


To destroy the cluster use the following command

    terrafor destroy


# IMPORTANT NOTE

Please note that AWS would charge for the resources which are deployed. This project should only used for test purposes. Please do ensure that all the resources have been deleted by manually checking the AWS console.

