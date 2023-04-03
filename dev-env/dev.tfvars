env = "dev"

vpc = {
    main = {                            #naming is our convinience. main will not leads to collision of another vpc if it is created. 
        vpc_cidr = "10.0.0.0/14"
    
    public_subnets = {
        public-azone1 = {
            name = "public-azone1"
            cidr_block = "10.0.0.0/24"
            availability_zone = "us-east-1a"
        }
        public-azone2 = {
            name = "public-azone2"
            cidr_block = "10.0.1.0/24"
            availability_zone = "us-east-1b"
        }
    }
    private_subnets = {
        web-azone1 = {
            name = "web-azone1"
            cidr_block = "10.0.2.0/24"
            availability_zone = "us-east-1a"
        }
        web-azone2 = {
            name = "web-azone2"
            cidr_block = "10.0.3.0/24"
            availability_zone = "us-east-1b"
        }
        app-azone1 = {
            name = "app-azone1"
            cidr_block = "10.0.4.0/24"
            availability_zone = "us-east-1a"
        }
        app-azone2 = {
            name = "app-azone2"
            cidr_block = "10.0.5.0/24"
            availability_zone = "us-east-1b"
        }
        db-azone1 = {
            name = "db-azone1"
            cidr_block = "10.0.6.0/24"
            availability_zone = "us-east-1a"
        }
        db-azone2 = {
            name = "db-azone2"
            cidr_block = "10.0.7.0/24"
            availability_zone = "us-east-1b"
        }
    }
    }
}