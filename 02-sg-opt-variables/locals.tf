locals {
  sg_map = {
    web_alb = {
     
      sg_name       = "web-alb"
      sg_description = "security group created for web application loadbalancer"
      
    }

    app-lb = {
     
      sg_name       = "app-lb"
      sg_description = "security group created for application loadbalancer"
      
    }

    mongodb = {
      
      sg_name       = "mongodb"
      sg_description = "security group created for mongodb instance"
      
    }

    user = {
      
      sg_name       = "user"
      sg_description = "security group created to attach user instances"
      
    }

    # add all your remaining SGs here...
    catalogue = {
      
      sg_name       = "catalogue"
      sg_description = "security group created to attach catalogue instances"
      
    }

    redis = {
      
      sg_name       = "redis"
      sg_description = "security group created to attach redis instances"
      
    }

    mysql = {
      
      sg_name       = "mysql"
      sg_description = "security group created to attach mysql instances"
      
    }

    rabbitmq = {
      source        = "git::https://github.com/Mygit-Naresh/modules.git"
      sg_name       = "rabbitmq"
      sg_description = "security group created to attach rabbitmq instances"
      
    }

    payment = {
      source        = "git::https://github.com/Mygit-Naresh/modules.git"
      sg_name       = "payment"
      sg_description = "security group created to attach payment instances"
      
    }

    cart = {
      source        = "git::https://github.com/Mygit-Naresh/modules.git"
      sg_name       = "cart"
      sg_description = "security group created to attach cart instances"
      
    }

    shipping = {
      source        = "git::https://github.com/Mygit-Naresh/modules.git"
      sg_name       = "shipping"
      sg_description = "security group created to attach shipping instances"
      
    }

    ratings = {
      source        = "git::https://github.com/Mygit-Naresh/modules.git"
      sg_name       = "ratings"
      sg_description = "security group created to attach ratings instances"
      
    }

    web = {
      source        = "git::https://github.com/Mygit-Naresh/modules.git"
      sg_name       = "web"
      sg_description = "security group created to attach web instances"
   
    }

    vpn = {
      source        = "git::https://github.com/Mygit-Naresh/modules.git"
      sg_name       = "vpn"
      sg_description = "security group created to attach vpn instances"
      
    }
  }
}

locals {
  sg_ids = {
    web_alb  = module.sg["web_alb"].sg_id
    app-lb   = module.sg["app-lb"].sg_id
    vpn      = module.sg["vpn"].sg_id
    mongodb  = module.sg["mongodb"].sg_id
    catalogue = module.sg["catalogue"].sg_id
    user     = module.sg["user"].sg_id
    cart     = module.sg["cart"].sg_id
    redis    = module.sg["redis"].sg_id
    rabbitmq = module.sg["rabbitmq"].sg_id
    mysql    = module.sg["mysql"].sg_id
    payment  = module.sg["payment"].sg_id
    shipping = module.sg["shipping"].sg_id
    ratings  = module.sg["ratings"].sg_id
    web      = module.sg["web"].sg_id
  }
}
