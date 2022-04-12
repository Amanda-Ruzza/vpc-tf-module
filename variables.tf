variable "project_name" {
    type = string
    description = "The prefix name of the project"

}

variable "region_name" {
    type = string
    description = "The name of the region"
}

variable "vpc_cidr"{
    type = string
    description = "The VPC CIDR"
}

variable "public_a_cidr"{
    type = string
    description = "The public subnet CIDR for AZ a"
}

variable "public_b_cidr"{
    type = string
    description = "The public subnet CIDR for AZ b"
}