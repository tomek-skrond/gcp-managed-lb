### gcp-managed-lb

To run this code, you have to create .env file with all essential variables for terraform:
```
export TF_VAR_credential_file=<credential_file_path>
export TF_VAR_project=<project_ID>
export TF_VAR_region=<region> #example: europe-west1
export TF_VAR_zone=<zone> #example: europe-west1-b
```

After completing `.env`, run:
```
$ terraform plan
```

Verify resources to be created in tf plan, then apply:
```
$ terraform apply
```

Code creates:
- Network resources (firewall,networks,subnets)
- VM template for creating MIG
- GCP managed instance group
- Managed L7 load balancer
- Health check for lb
