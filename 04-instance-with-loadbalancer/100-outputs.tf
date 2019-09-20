# Display dns information

output "http_ip" {
  value = aws_eip.public_http.*.public_ip
}

output "db_hostname" {
  value = aws_instance.db.*.private_dns
}

output "lb_hostname_http" {
  value = aws_lb.http.dns_name
}

output "lb_hostname_db" {
  value = aws_lb.db.dns_name
}

