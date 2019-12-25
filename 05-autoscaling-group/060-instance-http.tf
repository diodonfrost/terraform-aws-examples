#### INSTANCE HTTP ####

# Create load balancer
resource "aws_elb" "http" {
  name    = "http-lb"
  subnets = [aws_subnet.http.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
  tags = {
    Name = "http-lb"
  }
}

# Create autoscaling group
resource "aws_autoscaling_group" "http" {
  name                      = "http-autoscaling-group"
  max_size                  = var.autoscaling_http["max_size"]
  min_size                  = var.autoscaling_http["min_size"]
  desired_capacity          = var.autoscaling_http["desired_capacity"]
  health_check_type         = "ELB"
  default_cooldown          = "30"
  health_check_grace_period = "120"
  force_delete              = true
  launch_configuration      = aws_launch_configuration.http.name
  load_balancers            = [aws_elb.http.name]
  termination_policies      = ["OldestLaunchConfiguration"]
  vpc_zone_identifier       = [aws_subnet.http.id]
}

# Configure instance launching configuration
resource "aws_launch_configuration" "http" {
  name_prefix   = "http"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.user_key.key_name
  security_groups = [
    aws_security_group.administration.id,
    aws_security_group.web.id,
  ]
  user_data = file("scripts/first-boot-http.sh")
}

