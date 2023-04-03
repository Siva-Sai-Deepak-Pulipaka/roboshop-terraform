module "vpc" {
  source = "git::https://github.com/Siva-Sai-Deepak-Pulipaka/terraform-vpc.git"

  env = var.env
  tags = var.tags

  for_each = var.vpc
  vpc_cidr = each.value["vpc_cidr"]
  public_subnets = each.value["public_subnets"]
  private_subnets= each.value["private_subnets"]
}