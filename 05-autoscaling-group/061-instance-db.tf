#### INSTANCE DB ####

# Create load balancer
resource "aws_elb" "db" {
  name     = "db-lb"
  subnets  = [aws_subnet.db.id]
  internal = "true"

  listener {
    instance_port     = 3306
    instance_protocol = "tcp"
    lb_port           = 3306
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:3306"
    interval            = 30
  }
  tags = {
    Name = "db-lb"
  }
}

# Create autoscaling group
resource "aws_autoscaling_group" "db" {
  name                      = "db-autoscaling-group"
  max_size                  = var.autoscaling_db["max_size"]
  min_size                  = var.autoscaling_db["min_size"]
  desired_capacity          = var.autoscaling_db["desired_capacity"]
  health_check_type         = "ELB"
  default_cooldown          = "30"
  health_check_grace_period = "120"
  force_delete              = true
  load_balancers            = [aws_elb.db.name]
  termination_policies      = ["OldestLaunchTemplate"]
  vpc_zone_identifier       = [aws_subnet.db.id]

  launch_template {
    id      = aws_launch_template.db.id
    version = "$Latest"
  }
}

# Configure instance launch template
resource "aws_launch_template" "db" {
  name_prefix   = "db-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.user_key.key_name
  vpc_security_group_ids = [
    aws_security_group.administration.id,
    aws_security_group.web.id,
  ]
  user_data = filebase64("scripts/first-boot-db.sh")
}
