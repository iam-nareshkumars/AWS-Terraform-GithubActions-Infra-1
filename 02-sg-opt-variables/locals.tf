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
  sg_modules = {
    web_alb  = module.web_alb.sg_id
    app-lb   = module.app-lb.sg_id
    vpn      = module.vpn.sg_id
    mongodb  = module.mongodb.sg_id
    catalogue = module.catalogue.sg_id
    user     = module.user.sg_id
    cart     = module.cart.sg_id
    redis    = module.redis.sg_id
    rabbitmq = module.rabbitmq.sg_id
    mysql    = module.mysql.sg_id
    payment  = module.payment.sg_id
    shipping = module.shipping.sg_id
    ratings  = module.ratings.sg_id
    web      = module.web.sg_id
  }
}