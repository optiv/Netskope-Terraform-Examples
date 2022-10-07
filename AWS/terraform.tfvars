//name of the Publisher
publisher_name = "<Name of publisher to be used in both AWS EC2 and Netskope>"

/* For security purposes, AWS key names should be used as a Terraform environment variable, and not as a variable stored in the tfvars file. 
        The below is an example of how the AWS key COULD be used with the Netskope Terraform provider*/
//AWS Key Name
aws_key_name = "<AWS Keypair to be used for the EC2 instance>"

//AWS subnet ID
aws_subnet_id = "<Subnet ID in the AWS VPC where you want the publisher deployed to"

//AWS Security Group ID

aws_sg_id = "<Security group ID for the EC2 instance. Instance needs outbound connectivity to register with Netskope."

//Associate a Public IP true/false.  Omit this if you have a NAT gateway in the VPC
associate_public_ip_address = true
