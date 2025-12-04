module "securitygroup" {
  for_each = local.sg_map
  source = var.url
  environment = var.environment
  project = var.project
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name =  each.value.sg_name
  sg_description =  each.value.sg_description
}



# INCOMING RULUES #App ALB should accept connections only from cart,shipping etc since it is internal(NOT NOT YET)

resource "aws_security_group_rule" "mongodb_in_catalogue" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 27017
 to_port           = 27017
 protocol          = "tcp"
 security_group_id = module.securitygroup["mongodb"].sg_id
 source_security_group_id = module.securitygroup["catalogue"].sg_id
}
resource "aws_security_group_rule" "mongodb_in_user" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from user servers"
 from_port         = 27017
 to_port           = 27017
 protocol          = "tcp"
 security_group_id = module.securitygroup["mongodb"].sg_id
 source_security_group_id = module.securitygroup["user"].sg_id
}
resource "aws_security_group_rule" "redis_in_user" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from redis servers"
 from_port         = 6379
 to_port           = 6379
 protocol          = "tcp"
 security_group_id = module.securitygroup["redis"].sg_id
 source_security_group_id = module.securitygroup["user"].sg_id
}
resource "aws_security_group_rule" "redis_in_cart" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from cart servers"
 from_port         = 6379
 to_port           = 6379
 protocol          = "tcp"
 security_group_id = module.securitygroup["redis"].sg_id
 source_security_group_id = module.securitygroup["cart"].sg_id
}
resource "aws_security_group_rule" "mysql_in_shipping" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 3306
 to_port           = 3306
 protocol          = "tcp"
 security_group_id = module.securitygroup["mysql"].sg_id
 source_security_group_id = module.securitygroup["shipping"].sg_id
 }
resource "aws_security_group_rule" "mysql_in_ratings" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 3306
 to_port           = 3306
 protocol          = "tcp"
 security_group_id = module.mysql.sg_id
 source_security_group_id = module.ratings.sg_id
 }
resource "aws_security_group_rule" "rabbitmq_in_payment" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 5672
 to_port           = 5672
 protocol          = "tcp"
 security_group_id = module.rabbitmq.sg_id
 source_security_group_id = module.payment.sg_id
 }
 resource "aws_security_group_rule" "rabbitmq_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.rabbitmq.sg_id
 source_security_group_id = module.vpn.sg_id
}
 ########## Allow ibound rule 22 from VPN source group ###########
resource "aws_security_group_rule" "mongodb_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.mongodb.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "redis_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.redis.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "mysql_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.mysql.sg_id
 source_security_group_id = module.vpn.sg_id
}

#catalogue
resource "aws_security_group_rule" "catalogue_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.catalogue.sg_id
 source_security_group_id = module.vpn.sg_id
}
#  resource "aws_security_group_rule" "catalogue_in_web" {
#  type              = "ingress"
#  description       = "inbound rule for incoming traffic from vpn servers"
#  from_port         = 8080
#  to_port           = 8080
#  protocol          = "tcp"
#  security_group_id = module.catalogue.sg_id
#  source_security_group_id = module.web.sg_id
#  }
# resource "aws_security_group_rule" "catalogue_in_cart" {
#  type              = "ingress"
#  description       = "inbound rule for incoming traffic from vpn servers"
#  from_port         = 8080
#  to_port           = 8080
#  protocol          = "tcp"
#  security_group_id = module.catalogue.sg_id
#  source_security_group_id = module.cart.sg_id
#  }
resource "aws_security_group_rule" "catalogue_in_app-lb" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 8080
 to_port           = 8080
 protocol          = "tcp"
 security_group_id = module.catalogue.sg_id
 source_security_group_id = module.app-lb.sg_id
 }

resource "aws_security_group_rule" "cart_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.cart.sg_id
 source_security_group_id = module.vpn.sg_id
 }
resource "aws_security_group_rule" "cart_in_app-lb" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 8080
 to_port           = 8080
 protocol          = "tcp"
 security_group_id = module.cart.sg_id
 source_security_group_id = module.app-lb.sg_id
}
# resource "aws_security_group_rule" "cart_in_web" {
#  type              = "ingress"
#  description       = "inbound rule for incoming traffic from vpn servers"
#  from_port         = 8080
#  to_port           = 8080
#  protocol          = "tcp"
#  security_group_id = module.cart.sg_id
#  source_security_group_id = module.web.sg_id
# }
# resource "aws_security_group_rule" "cart_in_shipping" {
#  type              = "ingress"
#  description       = "inbound rule for incoming traffic from vpn servers"
#  from_port         = 8080
#  to_port           = 8080
#  protocol          = "tcp"
#  security_group_id = module.cart.sg_id
#  source_security_group_id = module.shipping.sg_id
# }
# resource "aws_security_group_rule" "cart_in_payment" {
#  type              = "ingress"
#  description       = "inbound rule for incoming traffic from vpn servers"
#  from_port         = 8080
#  to_port           = 8080
#  protocol          = "tcp"
#  security_group_id = module.cart.sg_id
#  source_security_group_id = module.payment.sg_id
# }

resource "aws_security_group_rule" "user_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.user.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "user_in_app-lb" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 8080
 to_port           = 8080
 protocol          = "tcp"
 security_group_id = module.user.sg_id
 source_security_group_id = module.app-lb.sg_id
}
# resource "aws_security_group_rule" "user_in_payment" {
#  type              = "ingress"
#  description       = "inbound rule for incoming traffic from vpn servers"
#  from_port         = 8080
#  to_port           = 8080
#  protocol          = "tcp"
#  security_group_id = module.user.sg_id
#  source_security_group_id = module.payment.sg_id
# }
# resource "aws_security_group_rule" "user_in_web" {
#  type              = "ingress"
#  description       = "inbound rule for incoming traffic from vpn servers"
#  from_port         = 8080
#  to_port           = 8080
#  protocol          = "tcp"
#  security_group_id = module.user.sg_id
#  source_security_group_id = module.web.sg_id
# }


resource "aws_security_group_rule" "payment_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.payment.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "payment_in_app-lb" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 8080
 to_port           = 8080
 protocol          = "tcp"
 security_group_id = module.payment.sg_id
 source_security_group_id = module.app-lb.sg_id
}
# resource "aws_security_group_rule" "payment_in_web" {
#  type              = "ingress"
#  description       = "inbound rule for incoming traffic from vpn servers"
#  from_port         = 8080
#  to_port           = 8080
#  protocol          = "tcp"
#  security_group_id = module.payment.sg_id
#  source_security_group_id = module.web.sg_id
# }



resource "aws_security_group_rule" "shipping_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.shipping.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "shipping_in_app-lb" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 8080
 to_port           = 8080
 protocol          = "tcp"
 security_group_id = module.shipping.sg_id
 source_security_group_id = module.app-lb.sg_id
}

# resource "aws_security_group_rule" "shipping_in_web" {
#  type              = "ingress"
#  description       = "inbound rule for incoming traffic from vpn servers"
#  from_port         = 8080
#  to_port           = 8080
#  protocol          = "tcp"
#  security_group_id = module.shipping.sg_id
#  source_security_group_id = module.web.sg_id
# }
resource "aws_security_group_rule" "ratings_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.ratings.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "ratings_in_app-lb" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 8080
 to_port           = 8080
 protocol          = "tcp"
 security_group_id = module.ratings.sg_id
 source_security_group_id = module.app-lb.sg_id
}
resource "aws_security_group_rule" "web_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.web.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "web_in_home" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 80
 to_port           = 80
 protocol          = "tcp"
 security_group_id = module.web.sg_id
 cidr_blocks = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "web_alb_in_home" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 443
 to_port           = 443
 protocol          = "tcp"
 security_group_id = module.web_alb.sg_id
 cidr_blocks = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "app-lb_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn"
 from_port         = 80
 to_port           = 80
 protocol          = "tcp"
 security_group_id = module.app-lb.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "app-lb_in_web" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from http"
 from_port         = 80
 to_port           = 80
 protocol          = "tcp"
 security_group_id = module.app-lb.sg_id
 source_security_group_id = module.web.sg_id
}
resource "aws_security_group_rule" "app-lb_in_cart" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from http"
 from_port         = 80
 to_port           = 80
 protocol          = "tcp"
 security_group_id = module.app-lb.sg_id
 source_security_group_id = module.cart.sg_id
}
resource "aws_security_group_rule" "app-lb_in_user" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from http"
 from_port         = 80
 to_port           = 80
 protocol          = "tcp"
 security_group_id = module.app-lb.sg_id
 source_security_group_id = module.user.sg_id
}
resource "aws_security_group_rule" "app-lb_in_payment" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from http"
 from_port         = 80
 to_port           = 80
 protocol          = "tcp"
 security_group_id = module.app-lb.sg_id
 source_security_group_id = module.payment.sg_id
}
resource "aws_security_group_rule" "app-lb_in_shipping" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from http"
 from_port         = 80
 to_port           = 80
 protocol          = "tcp"
 security_group_id = module.app-lb.sg_id
 source_security_group_id = module.shipping.sg_id
}
resource "aws_security_group_rule" "vpn_in_home" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from home"
 from_port         = 0
 to_port           = 65535
 protocol          = "tcp"
 security_group_id = module.vpn.sg_id
 cidr_blocks = ["0.0.0.0/0"]
 
}








