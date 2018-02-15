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

#### NETWORK PARAMS
variable "network_http" {
  default = {
    subnet_name  = "subnet_http"
    cidr         = "192.168.1.0/24"
  }
}
