## CMPE 279 Project: Security in Terraform using Terraform State

### Team Members:

| Name          | Email Address          |
| ------------- | ---------------------- |
| Ashish Gaurav | ashish.gaurav@sjsu.edu |
| Ankur Singh   | ankur.singh@sjsu.edu   |

## Tech Stack:

Terraform (version 1.0+)

## Description:

This repo contains the terraform code for the demo of our CMPE 279 Project: Security in Terraform using Terraform State.
The goal of this project is to demonstrate the security concerns with the local storage of the state file and how it can be resolved with the help terraform's remote backend. This repo contains 3 terraform codes: tf-demo1, tf-demo2 and tf-s3-dynamodb.

## Steps to run each of the 3 terraform codes:

- Before running any terraform command, make sure that you have a AWS account with enough permissions to create/modify/delete resources in AWS.
- Fetch your AWS Access key and AWS Secret Key
- Enter the following commands to export your AWS Keys as your environment variable: export AWS_ACCESS_KEY_ID=<YOUR ACCESS KEY>
  export AWS_SECRET_ACCESS_KEY=<YOUR SECRET KEY>

### Terraform code: tf-demo-1:

    This code is using local backend - it will create a simple ubuntu based web server (AWS EC2) with an AWS security group but the state file will be created in the local(where this code is stored)
    Commands to execute:

    - terraform init
    - terraform plan
    - terraform apply -auto-approve

### Terraform code: tf-s3-dynamodb:

    This code is used to create AWS S3 and AWS DynamoDb which will be used by Terraform's remote backend to store and maintain lock state file.
    Commands to execute:

    - terraform init
    - terraform plan
    - terraform apply -auto-approve

### Terraform code: tf-demo-2:

    This code is using remote backend - this has the remote backend code block where we are mentioning the s3 bucket and dynamodb table (created using tf-s3-dynamodb) and creating the same resources as we are in tf-demo1. This stores the state file in the s3 bucket and uses dynamodb table for managing the locking of the state file
    Commands to execute:

    - terraform init -reconfigure
    - terraform plan
    - terraform apply -auto-approve
