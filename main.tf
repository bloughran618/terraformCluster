provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           =  "ami-01bc990364452ab3e"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.instance.id]
  tags = {
    Name = "terraform-cluster"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              python3 -m http.server ${var.server_port}
              EOF
  user_data_replace_on_change = true
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP address of the web server"
}

resource "aws_security_group" "instance" {
  name = "terraform-example-cluster"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH traffic on port 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8081
}
