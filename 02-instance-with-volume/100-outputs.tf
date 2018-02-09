# Display dns information

output "http_hostname" {
  value = "${aws_instance.http.public_dns}"
}

output "db_hostname" {
  value = "${aws_instance.db.public_dns}"
}
