# Display dns information

output "http_ip" {
  value = aws_instance.http.*.private_ip
}

output "db_ip" {
  value = aws_instance.db.*.private_ip
}

