module "ec2" {
    for_each       = var.instances
    source         = "./ec2"
    component      = each.value["name"]
    instance_type  = each.value["type"]
    env            = var.env
    monitor        = each.value["monitor"]
  
}
//best practice is using for loop when we are dealing with module.
