resource "google_redis_instance" "cache" {
  name           = "memory-cache"
  tier           = "BASIC"
  memory_size_gb = 1

  location_id             = "us-central1-a"
  alternative_location_id = "us-central1-f"

  auth_enabled = true

  redis_version     = "REDIS_4_0"
  display_name      = "Terraform Test Instance"
  reserved_ip_range = "192.168.0.0/29"

  labels = {
    my_key    = "my_val"
    other_key = "other_val"
  }

  maintenance_policy {
    weekly_maintenance_window {
      day = "TUESDAY"
      start_time {
        hours = 0
        minutes = 30
        seconds = 0
        nanos = 0
      }
    }
  }

  transit_encryption_mode = "SERVER_AUTHENTICATION"
}