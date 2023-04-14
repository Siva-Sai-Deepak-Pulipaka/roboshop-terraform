module "vpc" {
  source = "git::https://github.com/Siva-Sai-Deepak-Pulipaka/terraform-vpc.git"
  env    = var.env
  tags   = var.tags
  default_route_table = var.default_route_table
  default_vpc_id      = var.default_vpc_id

  for_each       = var.vpc
  vpc_cidr       = each.value["vpc_cidr"]
  public_subnets = each.value["public_subnets"]
  private_subnets= each.value["private_subnets"]
}

module "docdb" {
  source = "git::https://github.com/Siva-Sai-Deepak-Pulipaka/terraform-docdb-module.git"
  env    = var.env
  tags   = var.tags
  
  subnet_ids  = local.db_subnet_ids
  vpc_id      = module.vpc["main"].vpc_id
  
  for_each                = var.docdb
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  no_of_instances         = each.value["no_of_instances"]
  instance_class          = each.value["instance_class"]
  allow_subnets           = lookup(local.subnet_cidr, each.value["allow_subnets"], null)

}

module "rds" {
  source = "git::https://github.com/Siva-Sai-Deepak-Pulipaka/terraform-rds-module.git"
  env    = var.env
  tags   = var.tags
 
  subnet_ids              = local.db_subnet_ids
  vpc_id      = module.vpc["main"].vpc_id

  for_each                = var.rds
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  no_of_instances         = each.value["no_of_instances"]
  instance_class          = each.value["instance_class"]
  allow_subnets           = lookup(local.subnet_cidr, each.value["allow_subnets"], null)

}

module "elasticache" {
  source = "git::https://github.com/Siva-Sai-Deepak-Pulipaka/terraform-elasticache-module.git"
  env    = var.env
  tags   = var.tags
  
  subnet_ids = local.db_subnet_ids
  vpc_id      = module.vpc["main"].vpc_id

  for_each                = var.elasticache
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  num_cache_nodes         = each.value["num_cache_nodes"]
  node_type               = each.value["node_type"]
  allow_subnets           = lookup(local.subnet_cidr, each.value["allow_subnets"], null)
 

}

module "rabbitmq" {
  source = "git::https://github.com/Siva-Sai-Deepak-Pulipaka/terraform-rabbitmq-module.git"
  env    = var.env
  tags   = var.tags
  bastion_cidr = var.bastion_cidr
  dns_domain   = var.dns_domain
  
  subnet_ids = local.db_subnet_ids
  vpc_id      = module.vpc["main"].vpc_id
  

  for_each                = var.rabbitmq
  instance_type           = each.value["instance_type"]
  allow_subnets           = lookup(local.subnet_cidr, each.value["allow_subnets"], null)
}

module "alb" {
  source = "git::https://github.com/Siva-Sai-Deepak-Pulipaka/terraform-alb-module.git"
  env    = var.env
  tags   = var.tags

  vpc_id = module.vpc["main"].vpc_id

  for_each           = var.alb
  name               = each.value["name"]
  internal           = each.value["internal"]
  load_balancer_type = each.value["load_balancer_type"]
  subnets            = lookup(local.subnet_ids, each.value["subnet_name"], null)
  allow_cidr         = each.value["allow_cidr"]
}

module "app" {

  depends_on = [module.vpc, module.docdb, module.rds, module.elasticache, module.alb, module.rabbitmq]

  source = "git::https://github.com/Siva-Sai-Deepak-Pulipaka/terraform-app-module.git"
  env    = var.env
  tags = merge(
    var.tags,
    { Monitor = "yes" }
  )
  bastion_cidr = var.bastion_cidr
  dns_domain   = var.dns_domain
  monitoring_nodes = var.monitoring_nodes
  
  vpc_id = module.vpc["main"].vpc_id

  for_each         = var.apps
  component        = each.value["component"]
  instance_type    = each.value["instance_type"]
  desired_capacity = each.value["desired_capacity"]
  max_size         = each.value["max_size"]
  min_size         = each.value["min_size"]
  port             = each.value["port"]
  listener_priority= each.value["listener_priority"]
  parameters       = each.value["parameters"]
  subnets          = lookup(local.subnet_ids, each.value["subnet_name"], null)
  allow_app_to     = lookup(local.subnet_cidr, each.value["allow_app_to"], null)    #allowing which ips to access
  alb_dns_name     = lookup(lookup(lookup(module.alb, each.value["alb"], null), "alb", null), "dns_name", null)
  listener_arn     = lookup(lookup(lookup(module.alb, each.value["alb"], null), "listener", null), "arn", null)


}

# output "alb" {
#   value = module.elasticache
# }

# load generator 


# resource "aws_spot_instance_request" "load-generator" {
#   ami                  = data.aws_ami.ami.id
#   instance_type        = "t3.medium"
#   wait_for_fulfillment = true
#   vpc_security_group_ids = ["sg-008351f2f82e44f0c"]   #we are giving our allow all vpcid because it will give public ip


#   tags = merge(
#     var.tags,
#     { Name = "load-generator" }
#   )
# }
# resource "aws_ec2_tag" "tag" {
#   key = "Name"
#   resource_id = aws_spot_instance_request.load-generator.spot_instance_id
#   value = "load-generator"
# }

# # load generator can be automated by the below code

# resource "null_resource" "load-gen" {
#   triggers = {
#     abc = aws_spot_instance_request.load-generator.public_ip
#   }
#   provisioner "remote-exec" {
#     connection {
#       host = aws_spot_instance_request.load-generator.public_ip
#       user = "root"
#       password = data.aws_ssm_parameter.ssh-pass.value
#     }
#     inline = [
#       "curl -s -L https://get.docker.com | bash",
#       "systemctl enable docker",
#       "systemctl start docker",
#       "docker pull robotshop/rs-load"
#     ]
#   }
# }