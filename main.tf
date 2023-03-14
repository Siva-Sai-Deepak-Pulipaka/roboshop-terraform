module "ec2" {
    for_each      = var.instances
    source        = "./ec2"
    component     = each.value["name"]
    instance_type = each.value["type"]
    password      = try(each.value["password"], "null")
    spot_instance_request_id = aws_spot_instance_request.ec2.id
  
}
//best practice is using for loop when we are dealing with module.