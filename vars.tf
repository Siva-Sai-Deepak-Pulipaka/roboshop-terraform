variable "instances" {
    default = {
        frontend = {
            name     = "frontend"
            type     = "t3.micro"
            index    = 1

        }
        mongodb = {
            name     = "mongodb"
            type     = "t3.micro"
            index    = 2
        }
        catalogue = {
            name     = "catalogue"
            type     = "t3.micro"
            index    = 3
        }
        redis = {
            name     = "redis"
            type     = "t3.micro"
            index    = 4
        }
        user = {
            name     = "user"
            type     = "t3.micro"
            index    = 5
        }
        cart = {
            name     = "cart"
            type     = "t3.micro"
            index    = 6
        }
        mysql = {
            name     = "mysql"
            type     = "t3.micro"
            password = "RoboShop@1"
            index    = 7
        }
        shipping = {
            name     = "shipping"
            type     = "t3.micro"
            password = "RoboShop@1"
            index    = 8
        }
        rabbitmq = {
            name     = "rabbitmq"
            type     = "t3.micro"
            password = "roboshop123"
            index    = 9
        }
        payment = {
            name     = "payment"
            type     = "t3.micro"
            password = "roboshop123"
            index    = 10
        }
        dispatch = {
            name     = "dispatch"
            type     = "t3.micro"
            password = "roboshop123"
            index    = 11
        }
    }
  
}
