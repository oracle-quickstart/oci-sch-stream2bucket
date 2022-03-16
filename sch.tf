

resource "oci_sch_service_connector" "sch" {
  compartment_id = var.compartment_ocid
  display_name   = var.sch_connector_name
  state          = "ACTIVE"

  source {
    kind = "streaming"
    stream_id = oci_streaming_stream.stream.id
  }

  target {
    kind                       = "objectStorage"
    compartment_id             = var.compartment_ocid
    bucket                     = oci_objectstorage_bucket.this.name
    namespace                  = oci_objectstorage_bucket.this.namespace
    object_name_prefix         = "logs"
    batch_rollover_size_in_mbs = 2
    batch_rollover_time_in_ms  = 60000
  }

}

data "oci_identity_tenancy" "current_user_tenancy" {
  provider   = oci.homeregion
  tenancy_id = var.tenancy_ocid
}

resource "oci_objectstorage_bucket" "this" {
  compartment_id        = var.compartment_ocid
  namespace             = data.oci_identity_tenancy.current_user_tenancy.name
  name                  = var.bucket_name
  access_type           = "NoPublicAccess"
  object_events_enabled = false
}


