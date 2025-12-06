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
    web_alb  = module.securitygroup["web_alb"].sg_id
    app-lb   = module.securitygroup["app-lb"].sg_id
    vpn      = module.securitygroup["vpn"].sg_id
    mongodb  = module.securitygroup["mongodb"].sg_id
    catalogue = module.securitygroup["catalogue"].sg_id
    user     = module.securitygroup["user"].sg_id
    cart     = module.securitygroup["cart"].sg_id
    redis    = module.securitygroup["redis"].sg_id
    rabbitmq = module.securitygroup["rabbitmq"].sg_id
    mysql    = module.securitygroup["mysql"].sg_id
    payment  = module.securitygroup["payment"].sg_id
    shipping = module.securitygroup["shipping"].sg_id
    ratings  = module.securitygroup["ratings"].sg_id
    web      = module.securitygroup["web"].sg_id
  }
}

# locals {
#   sg_in_rules = {
#     mongodb_in_catalogue = {
#       description = "inbound rule for incoming traffic from catalogue servers"
#       from_port         = 27017
#       to_port           = 27017
#       }
#   }
# }

locals {
  sg_rules = {
    # ---------- MongoDB ----------
    mongodb_in_catalogue = {
      type          = "ingress"
      description   = "incoming from catalogue"
      from_port     = 27017
      to_port       = 27017
      protocol      = "tcp"
      target_sg     = "mongodb"
      source_sg     = "catalogue"
      cidr_blocks   = null
    }

    mongodb_in_user = {
      type          = "ingress"
      description   = "incoming from user"
      from_port     = 27017
      to_port       = 27017
      protocol      = "tcp"
      target_sg     = "mongodb"
      source_sg     = "user"
      cidr_blocks   = null
    }

    # ---------- Redis ----------
    redis_in_user = {
      type          = "ingress"
      description   = "incoming from user"
      from_port     = 6379
      to_port       = 6379
      protocol      = "tcp"
      target_sg     = "redis"
      source_sg     = "user"
      cidr_blocks   = null
    }

    redis_in_cart = {
      type          = "ingress"
      description   = "incoming from cart"
      from_port     = 6379
      to_port       = 6379
      protocol      = "tcp"
      target_sg     = "redis"
      source_sg     = "cart"
      cidr_blocks   = null
    }

    # ---------- MySQL ----------
    mysql_in_shipping = {
      type        = "ingress"
      description = "incoming from shipping"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      target_sg   = "mysql"
      source_sg   = "shipping"
      cidr_blocks = null
    }

    mysql_in_ratings = {
      type        = "ingress"
      description = "incoming from ratings"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      target_sg   = "mysql"
      source_sg   = "ratings"
      cidr_blocks = null
    }


    ############################################
    # ---------------- RabbitMQ ----------------
    ############################################

    rabbitmq_in_payment = {
      type        = "ingress"
      description = "incoming from payment"
      from_port   = 5672
      to_port     = 5672
      protocol    = "tcp"
      target_sg   = "rabbitmq"
      source_sg   = "payment"
      cidr_blocks = null
    }

    rabbitmq_in_vpn = {
      type        = "ingress"
      description = "incoming from vpn"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      target_sg   = "rabbitmq"
      source_sg   = "vpn"
      cidr_blocks = null
    }



    ############################################
    # ---------------- Catalogue ----------------
    ############################################

    catalogue_in_vpn = {
      type        = "ingress"
      description = "incoming from vpn"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      target_sg   = "catalogue"
      source_sg   = "vpn"
      cidr_blocks = null
    }

    catalogue_in_app_lb = {
      type        = "ingress"
      description = "incoming from app-lb"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      target_sg   = "catalogue"
      source_sg   = "app-lb"
      cidr_blocks = null
    }



    ############################################
    # ---------------- Cart ---------------------
    ############################################

    cart_in_vpn = {
      type        = "ingress"
      description = "incoming from vpn"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      target_sg   = "cart"
      source_sg   = "vpn"
      cidr_blocks = null
    }

    cart_in_app_lb = {
      type        = "ingress"
      description = "incoming from app-lb"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      target_sg   = "cart"
      source_sg   = "app-lb"
      cidr_blocks = null
    }



    ############################################
    # ---------------- User ---------------------
    ############################################

    user_in_vpn = {
      type        = "ingress"
      description = "incoming from vpn"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      target_sg   = "user"
      source_sg   = "vpn"
      cidr_blocks = null
    }

    user_in_app_lb = {
      type        = "ingress"
      description = "incoming from app-lb"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      target_sg   = "user"
      source_sg   = "app-lb"
      cidr_blocks = null
    }



    ############################################
    # ---------------- Payment ------------------
    ############################################

    payment_in_vpn = {
      type        = "ingress"
      description = "incoming from vpn"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      target_sg   = "payment"
      source_sg   = "vpn"
      cidr_blocks = null
    }

    payment_in_app_lb = {
      type        = "ingress"
      description = "incoming from app-lb"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      target_sg   = "payment"
      source_sg   = "app-lb"
      cidr_blocks = null
    }



    ############################################
    # ---------------- Shipping -----------------
    ############################################

    shipping_in_vpn = {
      type        = "ingress"
      description = "incoming from vpn"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      target_sg   = "shipping"
      source_sg   = "vpn"
      cidr_blocks = null
    }

    shipping_in_app_lb = {
      type        = "ingress"
      description = "incoming from app-lb"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      target_sg   = "shipping"
      source_sg   = "app-lb"
      cidr_blocks = null
    }



    ############################################
    # ---------------- Ratings ------------------
    ############################################

    ratings_in_vpn = {
      type        = "ingress"
      description = "incoming from vpn"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      target_sg   = "ratings"
      source_sg   = "vpn"
      cidr_blocks = null
    }

    ratings_in_app_lb = {
      type        = "ingress"
      description = "incoming from app-lb"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      target_sg   = "ratings"
      source_sg   = "app-lb"
      cidr_blocks = null
    }



    ############################################
    # ---------------- Web ----------------------
    ############################################

    web_in_vpn = {
      type        = "ingress"
      description = "incoming from vpn"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      target_sg   = "web"
      source_sg   = "vpn"
      cidr_blocks = null
    }

    web_in_home = {
      type        = "ingress"
      description = "incoming from internet"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      target_sg   = "web"
      source_sg   = null
      cidr_blocks = ["0.0.0.0/0"]
    }



    ############################################
    # ---------------- App-LB -------------------
    ############################################

    app_lb_in_vpn = {
      type        = "ingress"
      description = "incoming from vpn"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      target_sg   = "app-lb"
      source_sg   = "vpn"
      cidr_blocks = null
    }

    app_lb_in_web = {
      type        = "ingress"
      description = "incoming from web"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      target_sg   = "app-lb"
      source_sg   = "web"
      cidr_blocks = null
    }

    app_lb_in_cart = {
      type        = "ingress"
      description = "incoming from cart"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      target_sg   = "app-lb"
      source_sg   = "cart"
      cidr_blocks = null
    }

    app_lb_in_user = {
      type        = "ingress"
      description = "incoming from user"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      target_sg   = "app-lb"
      source_sg   = "user"
      cidr_blocks = null
    }

    app_lb_in_payment = {
      type        = "ingress"
      description = "incoming from payment"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      target_sg   = "app-lb"
      source_sg   = "payment"
      cidr_blocks = null
    }

    app_lb_in_shipping = {
      type        = "ingress"
      description = "incoming from shipping"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      target_sg   = "app-lb"
      source_sg   = "shipping"
      cidr_blocks = null
    }

  }


    # ---------- Example CIDR rule ----------
  /*   web_in_home = {
      type          = "ingress"
      description   = "incoming from internet"
      from_port     = 80
      to_port       = 80
      protocol      = "tcp"
      target_sg     = "web"
      source_sg     = null
      cidr_blocks   = ["0.0.0.0/0"]
    } */
  }

