variable "aws_region" {
    default = "us-east-1"
}

#output "value"{

#value = "${var.aws_region}"
#}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
#variable "key_name" {
#	default = "hashterraform"
#}

variable "subnets_cidr" {
    #type = list
    default ="10.0.1.0/24"
}

variable "azs" {
	#type = list
	default = "us-east-1a"
}


