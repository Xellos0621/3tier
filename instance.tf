resource "aws_instance" "public_ec2_1" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    subnet_id = "public_sub_1"
    tags = {
        Name = "public1"
    }
}

resource "aws_instance" "public_ec2_2" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    subnet_id = "public_sub_2"
    tags = {
        Name = "public2"
    }
}

resource "aws_instance" "private_ec2_1" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    subnet_id = "private_sub_1"
    tags = {
        Name = "public2"
    }
}

resource "aws_instance" "private_ec2_2" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    subnet_id = "private_sub_2"
    tags = {
        Name = "public2"
    }
}
