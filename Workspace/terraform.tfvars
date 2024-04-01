# tfc_hostname = "app.terraform.io"
organization = "EffulgenceTech"
project_id   = "tekoh"
role_name    = "tfc-role"
workspaces = [
  {
    workspace_name = "workspace1"
    working_dir    = "projects/prod"
    vcs_identifier = "rtekoh/Terraform-workshop"
    aws_account_id = "082996641203"
    oauth_token_id = "ot-qqvUkpsFKgrChmBj"
  },
  {
    workspace_name = "workspace2"
    working_dir    = "projects/dev"
    vcs_identifier = "rtekoh/Terraform-workshop"
    aws_account_id = "082996641203"
    oauth_token_id = "ot-qqvUkpsFKgrChmBj"
  },
  # Add more workspaces as needed
]
