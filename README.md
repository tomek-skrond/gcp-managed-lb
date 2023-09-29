### gcp-managed-lb
Project that creates a managed instance group with load balancers on GCP using Terraform & Github Actions. <br>
If you want to deploy using Terraform CLI on your local machine, skip the Github Actions [configuration](https://github.com/tomek-skrond/gcp-managed-lb/master/README.md#github-actions).

Code creates:
- Network resources (firewall,networks,subnets)
- VM template for creating MIG
- GCP managed instance group
- Managed L7 load balancer
- Health check for lb

### Github Actions
To successfully run github actions workflow assigned to this project, create repository secrets shown below:
![image](https://github.com/tomek-skrond/gcp-managed-lb/assets/58492207/4f63b809-36a8-41bd-ba94-372aab118080)

After every successfull push to the repository main branch, github actions will activate workflow (`.github/workflows/terraform.yml`) that performs `terraform init`. After running basic check, you have an option to run another workflow option:
- plan
- apply
- destroy

Each of these workflows execute terraform commands on the GCP project described in your configuration.

### Quick Guide

To run this code, you have to create .env file with all essential variables for terraform:
```
export GOOGLE_APPLICATION_CREDENTIALS=<default_gcloud_cli_credentials> # example: "~.config/gcloud/application_default_credentials.json"
export TF_VAR_credential_file=<credential_file_path>
export TF_VAR_project=<project_ID>
export TF_VAR_region=<region> #example: europe-west1
export TF_VAR_zone=<zone> #example: europe-west1-b
export TF_VAR_bucket_name=<backend_bucket_name> #example: "gh-actionsbucket"
```

Source the `.env` file:
```
$ . .env
```

After completing `.env`, navigate to `/kickstart` directory and run following commands:
```
$ terraform init
$ terraform plan
$ terraform apply
```
`kickstart` module creates a backend bucket that will be used to store terraform state file for the infrastructure.

If terraform apply was successfull, it should output name of the backend bucket. <br>

After deploying a bucket, proceed to the home directory of repo and initialize terraform with additional args (these tie previously created bucket with terraform state file):
```
$ terraform init \
     -backend-config="bucket=${TF_VAR_bucket_name}" \
     -backend-config="prefix=terraform/state"
```

Next, do `terraform plan`:
```
$ terraform plan
```

Verify resources to be created in tf plan, then apply:
```
$ terraform apply
```
