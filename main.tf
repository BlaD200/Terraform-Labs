terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "vsynytsyn-key"
  vpc_security_group_ids = ["sg-01142ec3c87ec19dd"]

  tags = {
    Name = "Synytsyn Lab5"
  }
}

