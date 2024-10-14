

output "out_subnet_srv" {
  value = aws_subnet.srv.id
}

output "out_subnet_srv_cidr_block" {
  value = aws_subnet.srv.cidr_block
}

output "out_subnet_dmz" {
  value = aws_subnet.dmz.id
}



output "out_vpc_id" {
  value = aws_vpc.vpc-prd.id

}



output "private_subnets_ids" {
  value = [for subnet in aws_subnet.eks_private_subnets : subnet.id]
}

output "private_subnets_cidr_block" {
  value = [for subnet in aws_subnet.eks_private_subnets : subnet.cidr_block]
}

output "rds_database_subnets" {
  value = [for subnet in aws_subnet.rds_database_subnets : subnet.id]
}