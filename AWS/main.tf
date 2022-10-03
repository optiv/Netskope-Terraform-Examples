/*This block of code tells Terraform what provider to obtain from the Terraform repository.  
    Running terraform init will pull and install the correct information in the project directory
*/
terraform {
    required_providers {
        netskope = {
        version = "0.2.1"
        source  = "netskopeoss/netskope"
        }
    }
}

/*This section is used for the Netskope API key
    It is highly reccomended to use environment variables.
        Below are the commands to use to set environment variables on a system. 
        
    
    MacOS or Linux
        export NS_BaseURL=<Base URL>
        export NS_ApiToke<API Token>

    Windows
        set NS_BaseURL=<Base URL>
        set NS_ApiToken<API Token>
*/

/* If you use the provider block in leiu of environment, DO NOT commit this file to a public or unsecured repository.
provider "netskope" {
    baseurl = "https://<tenant>.goskope.com"
    apitoken = "<API Token>"
}*/

//This block will define what AWS region the NPA publisher will be deployed into
provider "aws" {
  region = "<AWS Region>" //ex. us-east-2
}

/*This modudule is used to interact with AWS to deploy the publisher AMI, along with creating the Netskope Publisher within Netskope. 
    in my demo, I use the AWS CLI to authenticate into AWS
*/
module "publisher-aws" {
  source  = "netskopeoss/publisher-aws/netskope"
  version = "0.1.2"

  publisher_name              = var.publisher_name
  aws_key_name                = var.aws_key_name
  aws_subnet                  = var.aws_subnet_id
  aws_security_group          = var.aws_sg_id
  associate_public_ip_address = var.associate_public_ip_address
  
}

//This block will create the private applicaiton within Netskope, and assign the app to the publisher, based on the output from the AWS Module
resource "netskope_privateapps" "PrivateApp" {
    app_name = "<Private Application name>" //ex. My Private Application
    host     = "<Host IP or FQDN>" //ex. 10.0.15.199

    protocols {
            type = "<Protocol tcp/udp" //ex. tcp
            port = "<Port(s)>" //ex 22, 80, 8080-8085 
    }

    publisher {
            publisher_id   = module.publisher-aws.publisher_id
            publisher_name = module.publisher-aws.publisher_name
    }
}