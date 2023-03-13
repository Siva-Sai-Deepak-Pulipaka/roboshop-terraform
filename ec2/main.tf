resource "aws_spot_instance_request" "ec2" {
    ami = "ami-0a017d8ceb274537d"
    instance_type = "t3.micro"
    vpc_security_group_ids = [ "sg-008351f2f82e44f0c" ]
    instance_interruption_behavior = "stop"
    tags = {
        Name = "demo"
    }
    
  
}