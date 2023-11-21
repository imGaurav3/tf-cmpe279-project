provider "aws" {
  region = "us-east-1"
}

# Creates an Ubuntu based EC2 instance
resource "aws_instance" "test" {
  ami           = "ami-0261755bbcb8c4a84"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "Demo for CMPE 279 Project with external tf state storage! - Take3" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true
  vpc_security_group_ids      = [aws_security_group.sg1.id]
  tags = {
    Name = "cmpe279-project-demo-2"
  }
}

# Creates a Security Group opening port 8080
resource "aws_security_group" "sg1" {
  name = "cmpe279-demo-2-sg"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Code Block for storing and managing the state file using S3 & DynamoDB
terraform {
  backend "s3" {
    bucket = "cmpe279-demo-tf-state"
    key    = "demo2/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "tf-cmpe279-project-state-locks"
    encrypt        = true
  }
}
