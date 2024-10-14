### root / locals

locals {
  aws_profile    = ""
  country_suffix = ""
  region         = "us-east-1"


  ### VPC prd id for data source if it was previos crated ####

  vpc_cidr = {
    dev = "172.28.0.0/16",
    prd = "10.28.0.0/16",
  }


  allow_from_all = "0.0.0.0/0"

  
  security_groups_services = {

    name        = "default-sg-"
    description = "default sg asignated"

    ingress = {

      ssh = {
        from        = 22
        to          = 22
        protocol    = "tcp"
        cidr_blocks = [local.allow_from_all]
      }

      ssh = {
        from        = 22052
        to          = 22052
        protocol    = "tcp"
        cidr_blocks = [local.allow_from_all]
      }

      http = {
        from        = 8080
        to          = 8080
        protocol    = "tcp"
        cidr_blocks = [local.allow_from_all]
      }

    }

  }

  security_groups_reverso = {

    name        = "default-sg-"
    description = "default sg asignated"

    ingress = {

      ssh = {
        from        = 22052
        to          = 22052
        protocol    = "tcp"
        cidr_blocks = [local.allow_from_all]
      }

      http = {
        from        = 80
        to          = 80
        protocol    = "tcp"
        cidr_blocks = [local.allow_from_all]
      }

      https = {
        from        = 443
        to          = 443
        protocol    = "tcp"
        cidr_blocks = [local.allow_from_all]
      }

    }

  }

  security_groups_ipsec = {

    name        = "default-sg-"
    description = "default sg asignated"

    ingress = {

      ssh = {
        from        = 22052
        to          = 22052
        protocol    = "tcp"
        cidr_blocks = [local.allow_from_all]
      }

      udp_500 = {
        from        = 500
        to          = 500
        protocol    = "udp"
        cidr_blocks = [local.allow_from_all]
      }

      udp_4500 = {
        from        = 4500
        to          = 4500
        protocol    = "udp"
        cidr_blocks = [local.allow_from_all]
      }


    }

  }


  security_groups_rds = {

    name        = "default-sg-"
    description = "default sg asignated"

    ingress = {

      ssh = {
        from        = 3306
        to          = 3306
        protocol    = "tcp"
        cidr_blocks = [local.allow_from_all]
      }

    }

  }

}

