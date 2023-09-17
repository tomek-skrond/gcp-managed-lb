output "load-balancer-instances" {
    description = "load balancer URL Map"
    value = google_compute_backend_service.default
}