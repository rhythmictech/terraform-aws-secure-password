# basic example
A basic example for this repository

## Code
Look to [main.tf](./main.tf), or be helpful and copy/paste that code here.

## Applying
```
>  terraform apply

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

example = {
  "tags_module" = {
    "name" = "TEST"
    "name32" = "TEST"
    "name6" = "TEST"
    "namenosymbols" = "TEST"
    "tags" = {
      "Name" = "TEST"
      "terraform_managed" = true
      "terraform_module" = "terraform-terraform-tags-1.0.0"
      "terraform_root_module" = "."
      "terraform_workspace" = "default"
    }
    "tags_as_list_of_maps" = [
      {
        "key" = "Name"
        "value" = "TEST"
      },
      {
        "key" = "terraform_managed"
        "value" = true
      },
      {
        "key" = "terraform_module"
        "value" = "terraform-terraform-tags-1.0.0"
      },
      {
        "key" = "terraform_root_module"
        "value" = "."
      },
      {
        "key" = "terraform_workspace"
        "value" = "default"
      },
    ]
    "tags_no_name" = {
      "terraform_managed" = true
      "terraform_module" = "terraform-terraform-tags-1.0.0"
      "terraform_root_module" = "."
      "terraform_workspace" = "default"
    }
  }
}
```
