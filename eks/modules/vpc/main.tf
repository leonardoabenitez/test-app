
locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}



resource "aws_vpc" "vpc-prd" {
  cidr_block = var.vpc_cidr_in

  tags = {
    Env  = "prd",
    Name = "vpc-${var.country_suffix_in}-prd"
  }
}

resource "aws_internet_gateway" "ig-prd" {
  vpc_id = aws_vpc.vpc-prd.id

  tags = {
    Name = "igw-${var.country_suffix_in}-prd"
  }
}

resource "aws_subnet" "dmz" {
  vpc_id     = aws_vpc.vpc-prd.id
  cidr_block = cidrsubnet(var.vpc_cidr_in, 8, 0)

  tags = {
    Name = "subnet-${var.country_suffix_in}-prd-dmz"
  }
}






resource "aws_subnet" "srv" {
  vpc_id     = aws_vpc.vpc-prd.id
  cidr_block = cidrsubnet(var.vpc_cidr_in, 8, 1)

  tags = {
    Name = "subnet-${var.country_suffix_in}-prd-srv"
  }
}




data "aws_availability_zones" "available" {
  state = "available"
}



resource "aws_subnet" "eks_public_subnets" {

  for_each = { for idx, az_name in local.azs : idx => az_name }

  vpc_id            = var.vpc_id_in
  cidr_block        = cidrsubnet(var.vpc_cidr_in, 8, each.key + 48)
  availability_zone = local.azs[each.key]

  map_public_ip_on_launch = true

  tags = {
    Name                     = "subnet-${var.country_suffix_in}-prd-eks_public"
    "kubernetes.io/role/elb" = "1"
  }
}


resource "aws_subnet" "eks_private_subnets" {

  for_each = { for idx, az_name in local.azs : idx => az_name }

  vpc_id                  = var.vpc_id_in
  cidr_block              = cidrsubnet(var.vpc_cidr_in, 8, each.key + 62)
  availability_zone       = local.azs[each.key]
  map_public_ip_on_launch = true

  tags = {
    Name                              = "subnet-${var.country_suffix_in}-prd-eks_private"
    "kubernetes.io/role/internal-elb" = "1"
  }
}




resource "aws_default_route_table" "default_route" {
  default_route_table_id = aws_vpc.vpc-prd.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-prd.id
  }

}


