data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]
}

//The above data block is prerequisite for allowing to create ec2 instance

resource "aws_spot_instance_request" "ec2" {
  ami                     = data.aws_ami.ami.image_id
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.sg.id]

  tags = {
    Name = var.component
  }
    
}

resource "null_resource" "provisioner" {
  depends_on = [aws_spot_instance_request.ec2[var.instance_count]] //we have included this line because remote-exec will take some time. so we have included depends_on parameter. This will ensure you after the instance is fully created which we mentioned in depends on parameter, then only remote-exec will request to connect.  
    provisioner "remote-exec" {
    connection {
          host     = aws_spot_instance_request.ec2.public_ip
          user     = "centos"
          password = "DevOps321"
    }
      inline = [
        
        "git clone https://github.com/Siva-Sai-Deepak-Pulipaka/roboshop-shell-script.git",
        "cd roboshop-shell-script",
        "sudo bash ${var.component}.sh ${var.password}"
      ]

  }

}


resource "aws_security_group" "sg" {
  name        = "${var.component}-${var.env}-sg"
  description = "Allow TLS inbound traffic"
  
  ingress {
    description      = "Allowing all for incoming"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component}-${var.env}-sg"
  }
}

resource "aws_route53_record" "record" {
  zone_id = "Z017354339FNHXHAHU536"
  name    = "${var.component}-dev.easydevops.online"
  type    = "A"
  ttl     = 30
  records = [aws_spot_instance_request.ec2.private_ip]
}

variable "component" {}
variable "instance_type" {}
variable "env" {
  default = "dev"
}
variable "password" {}
variable "instance_count" {}
