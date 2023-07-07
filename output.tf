output "ip" {
  value = "${aws_instance.public_ec2_1.public_ip}"
}