## Copyright (c) 2020, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "current_user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}

variable "bucket_name" {
  default = "StreamArchivalbucket"
}

variable "stream_name" {
  default = "demo_stream_1"
}

variable "stream_partitions" {
  default = "2"
}

variable "stream_pool_name" {
  default = "demo_pool_1"
}

variable "sch_connector_name" {
  default = "stream2bucket_connector"
}

data "oci_identity_regions" "oci_regions" {
  
  filter {
    name = "name" 
    values = [var.region]
  }

}

