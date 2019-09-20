# parms file for aws ec2 cloud

#### AMI

# Set ec2 image AMI
variable "ami" {
  # Canonical, Ubuntu, 16.04 LTS, amd64 xenial image build on 2018-01-09
  default = "ami-79873901"
}

#### VPC Network
variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

#### HTTP PARAMS
variable "network_http" {
  default = {
    subnet_name = "subnet_http"
    cidr        = "192.168.1.0/24"
  }
}

# Set number of instance
variable "desired_capacity_http" {
  default = 2
}

#### DB PARAMS
variable "network_db" {
  default = {
    subnet_name = "subnet_db"
    cidr        = "192.168.2.0/24"
  }
}

# Set number of instance
variable "desired_capacity_db" {
  default = 3
}

