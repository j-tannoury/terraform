module "qa-vpc" {
  source = "../../custom_vpc"
  cidr="10.0.2.0/24"
  enable_dns_support="true"  
  enable_classiclink="false"  
  enable_classiclink_dns_support="false"  
  enable_ipv6="false" 
  vpcname="qa01-vpc" 
  vpcenvironment="qaEnv-Engineering"  
  AWS_REGION="us-east-1"
}