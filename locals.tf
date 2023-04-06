# locals can be used as run time variables. they will be applied after terraform apply command
locals {
 subnet_ids = {

    db = tolist([module.vpc["main"].private_subnets["db-azone1"].id, module.vpc["main"].private_subnets["db-azone2"].id])
    app = tolist([module.vpc["main"].private_subnets["app-azone1"].id, module.vpc["main"].private_subnets["app-azone2"].id])
    web = tolist([module.vpc["main"].private_subnets["web-azone1"].id, module.vpc["main"].private_subnets["web-azone2"].id])
    public = tolist([module.vpc["main"].public_subnets["public-azone1"].id, module.vpc["main"].public_subnets["public-azone2"].id])
}

    subnet_cidr = {
    db = tolist([module.vpc["main"].private_subnets["db-azone1"].cidr_block, module.vpc["main"].private_subnets["db-azone2"].cidr_block])
    app = tolist([module.vpc["main"].private_subnets["app-azone1"].cidr_block, module.vpc["main"].private_subnets["app-azone2"].cidr_block])
    web = tolist([module.vpc["main"].private_subnets["web-azone1"].cidr_block, module.vpc["main"].private_subnets["web-azone2"].cidr_block])
    public = tolist([module.vpc["main"].public_subnets["public-azone1"].cidr_block, module.vpc["main"].public_subnets["public-azone2"].cidr_block])
    }

 db_subnet_ids = tolist([module.vpc["main"].private_subnets["db-azone1"].id, module.vpc["main"].private_subnets["db-azone2"].id])
 app_subnet_ids = tolist([module.vpc["main"].private_subnets["app-azone1"].id, module.vpc["main"].private_subnets["app-azone2"].id])
 web_subnet_ids = tolist([module.vpc["main"].private_subnets["web-azone1"].id, module.vpc["main"].private_subnets["web-azone2"].id])
}