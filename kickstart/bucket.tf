locals {
  bucket_name = "managed-lb-bucket"
}

resource "google_storage_bucket" "lbstate" {
  name          = local.bucket_name
  force_destroy = true
  location      = "EU"
  storage_class = "STANDARD"
  public_access_prevention = "enforced"

  versioning {
    enabled = true
  }
  # encryption {
  #   default_kms_key_name = google_kms_crypto_key.terraform_state_bucket.id
  # }
  # depends_on = [
  #   google_project_iam_member.project
  # ]

}

output "bucket_name" {
  value = local.bucket_name
}