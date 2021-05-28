
output "instanceid" {
  value = aws_instance.MyFirstInstance.id
}
output "public_ip" {
  value = aws_instance.MyFirstInstance.public_ip
}