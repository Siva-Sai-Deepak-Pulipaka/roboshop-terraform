variable "instances" {
    default = {
        frontend = {
            name     = "frontend"
            type     = "t3.micro"
            count    = 0
           
           
        }
        mongodb = {
            name     = "mongodb"
            type     = "t3.micro"
            count    = 1
           
           
        }
        catalogue = {
            name     = "catalogue"
            type     = "t3.micro"
            count    = 2
            
           
        }
        redis = {
            name     = "redis"
            type     = "t3.micro"
            count    = 3
        }
        user = {
            name     = "user"
            type     = "t3.micro"
            count    = 4
           
        }
        cart = {
            name     = "cart"
            type     = "t3.micro"
            count    = 5
           
        }
        mysql = {
            name     = "mysql"
            type     = "t3.micro"
            password = "RoboShop@1"
            count    = 6
        }
        shipping = {
            name     = "shipping"
            type     = "t3.micro"
            password = "RoboShop@1"
            count    = 7
        }
        rabbitmq = {
            name     = "rabbitmq"
            type     = "t3.micro"
            password = "roboshop123"
            count    = 8
        }
        payment = {
            name     = "payment"
            type     = "t3.micro"
            password = "roboshop123"
            count    = 9
        }
        dispatch = {
            name     = "dispatch"
            type     = "t3.micro"
            password = "roboshop123"
            count    = 10
        }
    }
  
}
