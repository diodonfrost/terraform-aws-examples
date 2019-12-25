# Manage load balancer

#### HTTP LOADBLANCER #####

# Create network load balancer
resource "aws_lb" "http" {
  name               = "http-lb"
  subnets            = aws_subnet.http.*.id
  load_balancer_type = "network"
  tags = {
    Name = "http-lb"
  }
}

# Create listener for load balancer http
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.http.id
  port              = "80"
  protocol          = "TCP"
  default_action {
    target_group_arn = aws_lb_target_group.http.id
    type             = "forward"
  }
}

# Create target group lb
resource "aws_lb_target_group" "http" {
  name     = "http-lb-target-group"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.terraform.id
  tags = {
    Name = "http-lb-target-group"
  }
}

# Add instance to load balancer
resource "aws_lb_target_group_attachment" "http" {
  for_each         = var.http_instance_names
  target_group_arn = aws_lb_target_group.http.arn
  target_id        = aws_instance.http[each.key].id
  port             = 80
}

#### DB LOADBLANCER #####

# Create a new load balancer for db instance
resource "aws_lb" "db" {
  name               = "db-lb"
  subnets            = aws_subnet.db.*.id
  load_balancer_type = "network"
  internal           = "true"
  tags = {
    Name = "db-lb"
  }
}

# Create listener for load balancer http
resource "aws_lb_listener" "db" {
  load_balancer_arn = aws_lb.db.id
  port              = "3306"
  protocol          = "TCP"
  default_action {
    target_group_arn = aws_lb_target_group.db.id
    type             = "forward"
  }
}

# Create target group lb
resource "aws_lb_target_group" "db" {
  name     = "db-lb-target-group"
  port     = 3306
  protocol = "TCP"
  vpc_id   = aws_vpc.terraform.id
  tags = {
    Name = "db-lb-target-group"
  }
}

# Add instance to load balancer
resource "aws_lb_target_group_attachment" "db" {
  for_each         = var.db_instance_names
  target_group_arn = aws_lb_target_group.db.arn
  target_id        = aws_instance.db[each.key].id
  port             = 80
}
