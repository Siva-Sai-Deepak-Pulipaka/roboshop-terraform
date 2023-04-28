# data "aws_ami" "ami" {
#   most_recent = true
#   name_regex = "devops-practice-ansible"
#   owners = ["self"]
# }



data "aws_ssm_parameter" "ssh-pass" {
  name = "${var.env}.ssh.pass"
}