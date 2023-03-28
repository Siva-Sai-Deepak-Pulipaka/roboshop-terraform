module "ec2" {
    for_each       = var.instances
    source         = "./ec2"
    component      = each.value["name"]
    instance_type  = each.value["type"]
    env            = var.env
    monitor        = try(each.value["monitor"], false)
  
}
//best practice is using for loop when we are dealing with module.
