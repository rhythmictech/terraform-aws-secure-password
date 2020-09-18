# terraform-aws-secure-password
Creates a password with a Lambda data source and saves it in a secrets manager secret, allowing the creation of passwords without saving them in state

[![tflint](https://github.com/rhythmictech/terraform-aws-secure-password/workflows/tflint/badge.svg?branch=main&event=push)](https://github.com/rhythmictech/terraform-aws-secure-password/actions?query=workflow%3Atflint+event%3Apush+branch%3Amain)
[![tfsec](https://github.com/rhythmictech/terraform-aws-secure-password/workflows/tfsec/badge.svg?branch=main&event=push)](https://github.com/rhythmictech/terraform-aws-secure-password/actions?query=workflow%3Atfsec+event%3Apush+branch%3Amain)
[![yamllint](https://github.com/rhythmictech/terraform-aws-secure-password/workflows/yamllint/badge.svg?branch=main&event=push)](https://github.com/rhythmictech/terraform-aws-secure-password/actions?query=workflow%3Ayamllint+event%3Apush+branch%3Amain)
[![misspell](https://github.com/rhythmictech/terraform-aws-secure-password/workflows/misspell/badge.svg?branch=main&event=push)](https://github.com/rhythmictech/terraform-aws-secure-password/actions?query=workflow%3Amisspell+event%3Apush+branch%3Amain)
[![pre-commit-check](https://github.com/rhythmictech/terraform-aws-secure-password/workflows/pre-commit-check/badge.svg?branch=main&event=push)](https://github.com/rhythmictech/terraform-aws-secure-password/actions?query=workflow%3Apre-commit-check+event%3Apush+branch%3Amain)
<a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=twitter" alt="follow on Twitter"></a>

## Example
Here's what using the module will look like
```hcl
module "secure_password" {
  source  = "rhythmictech/secure-password/aws"
  version = "~> 1.0.0-rc1"

  name    = "my-secure-pass"
  length  = 24
}

output "secret_name" {
  value = module.secure_password.secret_name
}

```

## About
Creates a password with a Lambda data source and saves it in a secrets manager secret, allowing the creation of passwords without saving them in state

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.28 |
| aws | >= 2.45, < 4.0 |
| null | ~> 2.1 |
| random | ~> 2.3 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.45, < 4.0 |
| null | ~> 2.1 |
| random | ~> 2.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| length | Length of the password to be created | `number` | n/a | yes |
| name | Moniker to apply to all resources in the module | `string` | n/a | yes |
| keepers | Arbitrary map of values that when changed will force a new password | `map(string)` | `{}` | no |
| lambda\_version\_constraint | NPM-style version constraint for the version of the lambda code you want to use | `string` | `"^1.0.0-rc1"` | no |
| lower | Whether to use lower case characters | `bool` | `true` | no |
| min\_lower | Minimum number of lowercase letters | `number` | `0` | no |
| min\_numeric | Minimum number of numeric characters to use. Must be at least 1 | `number` | `1` | no |
| min\_special | Minimum number of special characters to use. Must be at least 1 | `number` | `1` | no |
| min\_upper | Minimum number of uppercase characters to use. Must be at least 1 | `number` | `1` | no |
| number | Whether to use numbers | `bool` | `true` | no |
| override\_special | Supply your own list of special characters to use for string generation | `string` | `"!@#$%\u0026*()-_=+[]{}\u003c\u003e:?"` | no |
| secret\_description | Set a description for the secret | `string` | `"A password created by Terraform"` | no |
| special | Whether to use special characters | `bool` | `true` | no |
| tags | User-Defined tags | `map(string)` | `{}` | no |
| upper | Whether to use uppercase characters | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda\_version | The selected version of the Lambda code |
| lambda\_version\_info | all information about the selected version of the Lambda code |
| result | String result of Lambda execution |
| secret\_arn | ARN of the secret containing the password |
| secret\_name | Name of the secret containing the password |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## The Giants Underneath this Module
- [pre-commit.com](pre-commit.com)
- [terraform.io](terraform.io)
- [github.com/tfutils/tfenv](github.com/tfutils/tfenv)
- [github.com/segmentio/terraform-docs](github.com/segmentio/terraform-docs)
