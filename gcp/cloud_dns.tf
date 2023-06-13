resource "google_dns_managed_zone" "private-zone" {
  name        = "private-zone"
  dns_name    = "private.example.com."
  description = "Example private DNS zone"
  labels = {
    foo = "bar"
  }

  dnssec_config {
    default_key_specs {
        key_type = "keySigning"
        algorithm = "rsasha512"

    }
  }

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.network-1.id
    }
    networks {
      network_url = google_compute_network.network-2.id
    }
  }

  forwarding_config {
    target_name_servers {
      ipv4_address = "172.16.1.10"
    }
    target_name_servers {
      ipv4_address = "172.16.1.20"
    }
  }
}
