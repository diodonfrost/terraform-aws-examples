# Display dns information

output "http_hostname" {
  value = aws_eip.public_http.public_ip
}

output "db_hostname" {
  value = aws_eip.public_db.public_ip
}

