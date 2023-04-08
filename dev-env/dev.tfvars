env = "dev"
bastion_cidr = ["172.31.3.103/32"]       # /32 represents single IP
dns_domain = "easydevops.online"

vpc = {
    main = {                            #naming is our convinience. main will not leads to collision of another vpc if it is created. 
        vpc_cidr = "10.0.0.0/16"
    
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

docdb = {
    main = {
        engine                  = "docdb"
        engine_version          = "4.0.0"
        backup_retention_period = 2
        preferred_backup_window = "07:00-09:00"
        skip_final_snapshot     = true    #this is used as backup. before deleting it will store as snapshot. 
        no_of_instances         = 1
        instance_class          = "db.t3.medium"
        allow_subnets           = "app"
    }
}

rds = {
    main = {
        engine                  = "aurora-mysql"
        engine_version          = "5.7.mysql_aurora.2.11.1"
        backup_retention_period = 1
        preferred_backup_window = "07:00-09:00"
        skip_final_snapshot     = true
        no_of_instances         =  1
        instance_class          = "db.t3.small"
        allow_subnets           = "app"

    }
}

elasticache = {
    main = {
        engine                  = "redis"
        engine_version          = "6.x"     #we are using redis 6
        node_type               = "cache.t3.micro"
        num_cache_nodes         = 1
        allow_subnets           = "app"

    }
}

rabbitmq = {
    main = {
        instance_type        = "t3.micro"
        allow_subnets        = "app"
    }
}

alb = {
    public = {
        subnet_name         = "public"
        name                = "public"
        internal            = false
        load_balancer_type  = "application"
        allow_cidr          = ["0.0.0.0/0"]
    }
    private = {
        subnet_name         = "app"
        name                = "private"
        internal            = true
        load_balancer_type  = "application"
        allow_cidr          = ["10.0.2.0/24","10.0.3.0/24","10.0.4.0/24","10.0.5.0/24"]
    }
}

apps = {
    catalogue = {
        component        = "catalogue"
        instance_type    = "t3.micro"
        desired_capacity = 1
        max_size         = 4
        min_size         = 1
        subnet_name      = "app"
        port             = 8080
        allow_app_to     = "app"
        alb              = "private"
        listener_priority = 10
        parameters        = ["docdb"]
    }
    cart = {
        component        = "cart"
        instance_type    = "t3.micro"
        desired_capacity = 1
        max_size         = 4
        min_size         = 1
        subnet_name      = "app"
        port             = 8080
        allow_app_to     = "app"
        alb              = "private"
        listener_priority = 11
        parameters       = ["elasticache"]
    }
    user = {
        component        = "user"
        instance_type    = "t3.micro"
        desired_capacity = 1
        max_size         = 4
        min_size         = 1
        subnet_name      = "app"
        port             = 8080
        allow_app_to     = "app"
        alb              = "private"
        listener_priority = 12
        parameters       = []
    }
    payment = {
        component        = "payment"
        instance_type    = "t3.micro"
        desired_capacity = 1
        max_size         = 4
        min_size         = 1
        subnet_name      = "app"
        port             = 8080
        allow_app_to     = "app"
        alb              = "private"
        listener_priority = 13
        parameters       = []
    }
    shipping = {
        component        = "shipping"
        instance_type    = "t3.micro"
        desired_capacity = 1
        max_size         = 4
        min_size         = 1
        subnet_name      = "app"
        port             = 8080
        allow_app_to     = "app"
        alb              = "private"
        listener_priority = 14
        parameters       = ["rds"]
    }
    dispatch = {
        component        = "dispatch"
        instance_type    = "t3.micro"
        desired_capacity = 1
        max_size         = 4
        min_size         = 1
        subnet_name      = "app"
        port             = 8080
        allow_app_to     = "app"
        alb              = "private"
        listener_priority = 15
        parameters       = []
    }
    frontend = {
        component        = "frontend"
        instance_type    = "t3.micro"
        desired_capacity = 1
        max_size         = 4
        min_size         = 1
        subnet_name      = "web"
        port             = 80                     #nginx port
        allow_app_to     = "public"
        alb              = "public"
        listener_priority = 10
        parameters       = []
    }
}