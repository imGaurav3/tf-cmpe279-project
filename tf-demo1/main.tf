provider "aws" {
  region = "us-east-1"
}

# Creates an Ubuntu based EC2 instance
resource "aws_instance" "test1" {
  ami           = "ami-0261755bbcb8c4a84"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "Demo for CMPE 279 Project!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true
  vpc_security_group_ids      = [aws_security_group.sg2.id]
  tags = {
    Name = "cmpe279-project-demo-1"
  }
}

# Creates a Security Group opening port 8080
resource "aws_security_group" "sg2" {
  name = "cmpe279-demo-1-sg"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
