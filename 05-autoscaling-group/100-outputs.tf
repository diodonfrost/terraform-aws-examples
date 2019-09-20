# Display output information

# Display http loadbalancer dns name
output "lb_hostname_http" {
  value = aws_elb.http.dns_name
}

# Display db loadbalancer dns name
output "lb_hostname_db" {
  value = aws_elb.db.dns_name
}

