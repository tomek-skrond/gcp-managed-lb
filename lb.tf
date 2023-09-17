### VPC NETWORK ###
resource "google_compute_network" "default" {
    name = "lb-network"
    provider = google-beta
    auto_create_subnetworks = false
}

### SUBNET FOR BACKEND ###
resource "google_compute_subnetwork" "default" {
    name = "lb-subnet"
    provider = google-beta
    ip_cidr_range = "10.0.1.0/24"
    region = var.region
    network = google_compute_network.default.id
}

### EXTERNAL IP ###
resource "google_compute_global_address" "default" {
    provider = google-beta
    name = "lb-static-ip"
}

# url map
resource "google_compute_url_map" "default" {
  name            = "lb-url-map"
  provider        = google-beta
  default_service = google_compute_backend_service.default.id
}


### HTTP PROXY ###
resource "google_compute_target_http_proxy" "default" {
    name = "lb-target-http-proxy"
    provider = google-beta
    url_map = google_compute_url_map.default.id
}

### FORWARDING RULE ###
resource "google_compute_global_forwarding_rule" "default" {
  name = "lb-forwarding-rule"
  provider = google-beta
  ip_protocol = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range = "80"
  target = google_compute_target_http_proxy.default.id
}

resource "google_compute_backend_service" "default" {
  name                    = "lb-backend-service"
  provider                = google-beta
  protocol                = "HTTP"
  port_name               = "http"
  load_balancing_scheme   = "EXTERNAL"
  timeout_sec             = 10
  enable_cdn              = true
  custom_request_headers  = ["X-Client-Geo-Location: {client_region_subdivision}, {client_city}"]
  custom_response_headers = ["X-Cache-Hit: {cdn_cache_status}"]
  health_checks           = [google_compute_health_check.default.id]
  backend {
    group           = google_compute_instance_group_manager.default.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

# instance template
resource "google_compute_instance_template" "default" {
  name         = "lb-mig-template"
  provider     = google-beta
  machine_type = "e2-small"
  tags         = ["allow-health-check"]

  network_interface {
    network    = google_compute_network.default.id
    subnetwork = google_compute_subnetwork.default.id
    access_config {
      # add external ip to fetch packages
    }
  }
  disk {
    source_image = "debian-cloud/debian-10"
    auto_delete  = true
    boot         = true
  }

  # install nginx and serve a simple web page
  metadata = {
    startup-script = <<-EOF1
      #! /bin/bash
      set -euo pipefail

      export DEBIAN_FRONTEND=noninteractive
      apt-get update
      apt-get install -y nginx-light jq

      NAME=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/hostname")
      IP=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip")
      METADATA=$(curl -f -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/attributes/?recursive=True" | jq 'del(.["startup-script"])')

      cat <<EOF > /var/www/html/index.html
      <pre>
      Name: $NAME
      IP: $IP
      Metadata: $METADATA
      </pre>
      EOF
    EOF1
  }
  lifecycle {
    create_before_destroy = true
  }
}

# health check
resource "google_compute_health_check" "default" {
  name     = "lb-health-check"
  provider = google-beta
  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}


resource "google_compute_instance_group_manager" "default" {
  name     = "lb-manage-instance-group"
  provider = google-beta
  zone     = var.zone
  named_port {
    name = "http"
    port = 80
  }
  version {
    instance_template = google_compute_instance_template.default.id
    name              = "primary"
  }
  base_instance_name = "vm"
  target_size        = 2
}

# allow access from health check ranges
resource "google_compute_firewall" "default" {
  name          = "lb-fw-allow-health-check"
  provider      = google-beta
  direction     = "INGRESS"
  network       = google_compute_network.default.id
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  allow {
    protocol = "tcp"
  }
  target_tags = ["allow-health-check"]
}