#### INSTANCE DB ####

# Create instance
resource "aws_instance" "db" {
  count         = var.desired_capacity_db
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = aws_key_pair.user_key.key_name
  vpc_security_group_ids = [
    aws_security_group.administration.id,
    aws_security_group.db.id,
  ]
  subnet_id = aws_subnet.db.id
  user_data = file("scripts/first-boot-db.sh")
  tags = {
    Name = "db-instance${count.index}"
  }
}

