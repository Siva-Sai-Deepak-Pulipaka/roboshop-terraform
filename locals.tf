# locals can be used as run time variables. they will be applied after terraform apply command
locals {
#   trying to get private subnets
 db_subnet_ids = tolist([module.vpc["main"].private_subnets["db-azone1"].id, module.vpc["main"].private_subnets["db-azone2"].id])
 app_subnet_ids = tolist([module.vpc["main"].private_subnets["app-azone1"].id, module.vpc["main"].private_subnets["app-azone2"].id])
 web_subnet_ids = tolist([module.vpc["main"].private_subnets["web-azone1"].id, module.vpc["main"].private_subnets["web-azone2"].id])
}