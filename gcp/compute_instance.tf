resource "google_compute_instance" "instance" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  deletion_protection = false
  

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
    kms_key_self_link = ""
    disk_encryption_key_raw = ""
  }

  attached_disk {
    device_name = "/dev/disk/by-id/google-*"
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }

  shielded_instance_config {
    enable_integrity_monitoring = false
    enable_secure_boot = false
    enable_vtpm = false
  }

  network_interface {
    network = google_compute_network.network.name
    subnetwork = google_compute_subnetwork.subnetwork.name
    access_config {
        network_tier = "STANDARD"
    }
  }

}
resource "google_compute_instance" "master-instance" {
  name         = "master-test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  deletion_protection = false
  

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
    kms_key_self_link = ""
    disk_encryption_key_raw = ""
  }

  attached_disk {
    device_name = "/dev/disk/by-id/google-*"
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }

  shielded_instance_config {
    enable_integrity_monitoring = false
    enable_secure_boot = false
    enable_vtpm = false
  }

  network_interface {
    network = google_compute_network.network.name
    subnetwork = google_compute_subnetwork.subnetwork.name
    access_config {
        network_tier = "STANDARD"
    }
  }

}
resource "google_compute_instance" "node-instance" {
  name         = "node-test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  deletion_protection = false
  

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
    kms_key_self_link = ""
    disk_encryption_key_raw = ""
  }

  attached_disk {
    device_name = "/dev/disk/by-id/google-*"
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }

  shielded_instance_config {
    enable_integrity_monitoring = false
    enable_secure_boot = false
    enable_vtpm = false
  }

  network_interface {
    network = google_compute_network.network.name
    subnetwork = google_compute_subnetwork.subnetwork.name
    access_config {
        network_tier = "STANDARD"
    }
  }

}

resource "google_compute_instance_iam_binding" "instance_binding" {
  instinstance_name = google_compute_instance.instance.name
  role = "roles/compute.networkUser"
  members = ["allUsers"]
  # oak9: Define authorized users for the IAM policy
}

resource "google_compute_instance_iam_member" "instance_member" {
  instinstance_name = google_compute_instance.instance.name
  member = "allAuthenticatedUsers"
  # oak9: Define authorized users for the IAM policy
  role = "roles/compute.networkUser"
}


