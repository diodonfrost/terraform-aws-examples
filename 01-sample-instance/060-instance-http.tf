#### INSTANCE HTTP ####

# Create instance
resource "aws_instance" "http" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.user_key.key_name
  vpc_security_group_ids = [
    aws_security_group.administration.id,
    aws_security_group.web.id,
  ]
  subnet_id = aws_subnet.http.id
  user_data = file("scripts/first-boot.sh")
  tags = {
    Name = "http-instance"
  }
}

# Attach floating ip on instance http
resource "aws_eip" "public_http" {
  vpc        = true
  instance   = aws_instance.http.id
  depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "public-http"
  }
}

