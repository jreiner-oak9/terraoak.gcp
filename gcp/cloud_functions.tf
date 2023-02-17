
resource "google_cloudfunctions_function" "function" {
  name        = "function-test"
  description = "My function"
  runtime     = "nodejs14"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  https_trigger_security_level = "SECURE_OPTIONAL"
  entry_point           = "helloGET"
  ingress_settings = "ALLOW_ALL"
  vpc_connector_egress_settings = "PRIVATE_RANGES_ONLY"

}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
  # oak9: google_cloudfunctions_function_iam_member.member is not configured
}