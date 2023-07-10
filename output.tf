output "ip" {
    value = "${aws_instance.public_ec2_1.public_ip}"
}
output "alb" {
    value = aws_alb.public-alb01.dns_name
}