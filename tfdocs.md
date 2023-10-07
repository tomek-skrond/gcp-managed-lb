## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_backend_service.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_backend_service) | resource |
| [google-beta_google_compute_firewall.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_firewall) | resource |
| [google-beta_google_compute_global_address.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_global_address) | resource |
| [google-beta_google_compute_global_forwarding_rule.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_global_forwarding_rule) | resource |
| [google-beta_google_compute_health_check.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_health_check) | resource |
| [google-beta_google_compute_instance_group_manager.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_instance_group_manager) | resource |
| [google-beta_google_compute_instance_template.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_instance_template) | resource |
| [google-beta_google_compute_network.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_network) | resource |
| [google-beta_google_compute_subnetwork.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_subnetwork) | resource |
| [google-beta_google_compute_target_http_proxy.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_target_http_proxy) | resource |
| [google-beta_google_compute_url_map.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_url_map) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_credential_file"></a> [credential\_file](#input\_credential\_file) | n/a | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | n/a | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `any` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_load-balancer-instances"></a> [load-balancer-instances](#output\_load-balancer-instances) | load balancer URL Map |
