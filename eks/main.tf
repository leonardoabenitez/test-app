#### root / main ### 


module "vpc" {
  source = "./modules/vpc"

  country_suffix_in = local.country_suffix
  vpc_cidr_in       = local.vpc_cidr["prd"]
  vpc_id_in         = module.vpc.out_vpc_id

}


module "eks" {
  source = "./modules/eks"

  vpc_id_in          = module.vpc.out_vpc_id
  private_subnets_in = module.vpc.private_subnets_ids
  country_suffix_in  = local.country_suffix


}






