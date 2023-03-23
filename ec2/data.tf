data "aws_caller_identity" "current" {}
data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "devops-practice-ansible"            //  we replaced The old line because we need to install ansible on every machine. so instead of doing it manually, we created a image from an instance and make it available to our account. so no need to install ansible in every system we create. 
  owners           = [data.aws_caller_identity.current.account_id]
}

//The above data block is prerequisite for allowing to create ec2 instance