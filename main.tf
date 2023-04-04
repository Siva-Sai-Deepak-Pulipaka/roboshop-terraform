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

  for_each                = var.docdb
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  
  db_subnet_ids           = local.db_subnet_ids
  
  no_of_instances         = each.value["no_of_instances"]
  instance_class          = each.value["instance_class"]

}

module "rds" {
  source = "git::https://github.com/Siva-Sai-Deepak-Pulipaka/terraform-rds-module.git"
  env    = var.env
  tags   = var.tags

  for_each                = var.rds
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]

  db_subnet_ids           = local.db_subnet_ids
  
  no_of_instances         = each.value["no_of_instances"]
  instance_class          = each.value["instance_class"]

}

module "elasticache" {
  source = "git::https://github.com/Siva-Sai-Deepak-Pulipaka/terraform-elasticache-module.git"
  env    = var.env
  tags   = var.tags

  for_each                = var.elasticache
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  num_cache_nodes         = each.value["num_cache_nodes"]
  node_type               = each.value["node_type"]
  subnet_ids              = local.db_subnet_ids

}

module "rabbitmq" {
  source = "git::https://github.com/Siva-Sai-Deepak-Pulipaka/terraform-rabbitmq-module.git"
  env    = var.env
  tags   = var.tags

  for_each                = var.rabbitmq
  instance_type           = each.value["instance_type"]
}