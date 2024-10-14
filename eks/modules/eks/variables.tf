# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


variable "vpc_id_in" {}
variable "private_subnets_in" {}

variable "country_suffix_in" {
  description = "Country suffix: for example: CO,CL,US"
}


