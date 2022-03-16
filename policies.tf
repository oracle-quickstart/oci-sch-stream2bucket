## Copyright (c) 2020, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_identity_policy" "sch_policies" {
  depends_on = [
    oci_sch_service_connector.sch
  ]
  provider       = oci.homeregion
  compartment_id = var.compartment_ocid
  name           = "Sch_policies"
  description    = "Policy to provide access to service connector hub to write in object storage bucket"
  statements     = [
    
    "allow any-user to manage objects in compartment id ${var.compartment_ocid} where all { request.principal.type = 'serviceconnector', target.bucket.name = '${oci_objectstorage_bucket.this.name}' , request.principal.compartment.id = '${var.compartment_ocid}' } " ,
    "allow any-user to {STREAM_READ, STREAM_CONSUME} in compartment id ${var.compartment_ocid} where all { request.principal.type = 'serviceconnector', target.stream.id = '${oci_streaming_stream.stream.id}', request.principal.compartment.id = '${var.compartment_ocid}'} "
  ]
}
