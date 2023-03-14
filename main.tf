module "ec2" {
    for_each      = var.instances
    source        = "./ec2"
    component     = each.value["name"]
    instance_type = each.value["type"]
    password      = try(each.value["password"], "null")
  
}
//best practice is using for loop when we are dealing with module.
resource "aws_instance" "spot" {
    instance_type = module.ec2.instance_type
}