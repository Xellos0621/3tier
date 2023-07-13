resource "aws_alb" "public-alb01" {
  name = "pubic-alb01"
  subnets = ["${aws_subnet.public_sub_1.vpc_id}", "${aws_subnet.public_sub_2.vpc_id}"]

}
output "subnets" {
  value = aws_alb.public-alb01.subnets
}