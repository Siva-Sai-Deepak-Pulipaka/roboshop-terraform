# we are not mixing these variables in ec2 because these variables are parameters. ec2 variables are for infra. parameters are required in creating infra. instead we can create another repository for parameters as well.
bucket = "easydevops"
key = "dev/parameters/terraform.tfstate"
region = "us-east-1"
