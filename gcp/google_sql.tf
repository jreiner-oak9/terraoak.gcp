resource "google_sql_database_instance" "postgres" {
  name             = "postgres-instance-${random_id.db_name_suffix.hex}"
  database_version = "POSTGRES_14"

  settings {
    tier = "db-f1-micro"

    ip_configuration {

      ipv4_enabled = true

      dynamic "authorized_networks" {
        for_each = google_compute_instance.apps
        iterator = apps

        content {
          name  = apps.value.name
          value = apps.value.network_interface.0.access_config.0.nat_ip
        }
      }

      dynamic "authorized_networks" {
        for_each = local.onprem
        iterator = onprem

        content {
          name  = "onprem-${onprem.key}"
          value = onprem.value
        }
      }
      require_ssl = false # oak9: settings.ip_configuration.require_ssl should be set to any of True
    }

    backup_configuration {
      point_in_time_recovery_enabled = false
    }
  }
}

resource "google_sql_database_instance" "mysql" {
  name             = "mysql-instance-${random_id.db_name_suffix.hex}"
  database_version = "MYSQL_5_6"

  settings {
    tier = "db-f1-micro"

    ip_configuration {

      ipv4_enabled = true

      dynamic "authorized_networks" {
        for_each = google_compute_instance.apps
        iterator = apps

        content {
          name  = apps.value.name
          value = apps.value.network_interface.0.access_config.0.nat_ip
        }
      }

      dynamic "authorized_networks" {
        for_each = local.onprem
        iterator = onprem

        content {
          name  = "onprem-${onprem.key}"
          value = onprem.value
        }
      }
      require_ssl = false # oak9: settings.ip_configuration.require_ssl should be set to any of True
    }

    backup_configuration {
      point_in_time_recovery_enabled = false
    }
  }
}