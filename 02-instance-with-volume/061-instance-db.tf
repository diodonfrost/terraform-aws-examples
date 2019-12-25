#### INSTANCE DB ####

# Create instance
resource "aws_instance" "db" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.user_key.key_name
  vpc_security_group_ids = [
    aws_security_group.administration.id,
    aws_security_group.db.id,
  ]
  subnet_id = aws_subnet.http.id
  user_data = file("scripts/first-boot.sh")
  tags = {
    Name = "db-instance"
  }
}

# Attach floating ip on instance db
resource "aws_eip" "public_db" {
  vpc        = true
  instance   = aws_instance.db.id
  depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "public-db"
  }
}

# Create volume
resource "aws_ebs_volume" "db" {
  availability_zone = aws_instance.db.availability_zone
  size              = 15
}

# Attach volume to instance
resource "aws_volume_attachment" "db" {
  device_name  = "/dev/xvdh"
  force_detach = true
  volume_id    = aws_ebs_volume.db.id
  instance_id  = aws_instance.db.id
}

