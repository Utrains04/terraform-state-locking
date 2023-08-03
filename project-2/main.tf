provider "aws" {
   region     = "us-east-1"
   access_key = var.access_key
   secret_key = var.secret_key
}

#data for amazon linux
data "aws_ami" "amazon-2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "ec2_example" {
    ami = data.aws_ami.amazon-2.id
    instance_type = "t2.micro"
    tags = {
      Name = "EC2 Instance with remote state developper 2"
    }
}

terraform {
    backend "s3" {
        bucket = "terraformbackend-bucket1"
        key    = "terraformbackend-bucket1/remote/s3/terraform.tfstate"
        region     = "us-east-1"
        dynamodb_table = "dynamodb-state-locking"
    }
}