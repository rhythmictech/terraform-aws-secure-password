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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.28 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.45 |
| <a name="requirement_external"></a> [external](#requirement\_external) | >= 1.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.45 |
| <a name="provider_external"></a> [external](#provider\_external) | >= 1.2 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 2.1 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_invocation"></a> [lambda\_invocation](#module\_lambda\_invocation) | matti/resource/shell | ~>1.0.7 |
| <a name="module_lambda_invocation_result"></a> [lambda\_invocation\_result](#module\_lambda\_invocation\_result) | matti/resource/shell | ~>1.0.7 |
| <a name="module_lambda_version"></a> [lambda\_version](#module\_lambda\_version) | rhythmictech/find-release-by-semver/github | ~> 1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.secret_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.lambda_basic_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [null_resource.lambda_zip](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_string.trigger](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_iam_policy_document.assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.secret_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [external_external.sha](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_length"></a> [length](#input\_length) | Length of the password to be created | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Moniker to apply to all resources in the module | `string` | n/a | yes |
| <a name="input_keepers"></a> [keepers](#input\_keepers) | Arbitrary map of values that when changed will force a new password | `map(string)` | `{}` | no |
| <a name="input_lambda_version_constraint"></a> [lambda\_version\_constraint](#input\_lambda\_version\_constraint) | NPM-style version constraint for the version of the lambda code you want to use | `string` | `"^1.0.3"` | no |
| <a name="input_lower"></a> [lower](#input\_lower) | Whether to use lower case characters | `bool` | `true` | no |
| <a name="input_min_lower"></a> [min\_lower](#input\_min\_lower) | Minimum number of lowercase letters | `number` | `0` | no |
| <a name="input_min_numeric"></a> [min\_numeric](#input\_min\_numeric) | Minimum number of numeric characters to use. Must be at least 1 | `number` | `1` | no |
| <a name="input_min_special"></a> [min\_special](#input\_min\_special) | Minimum number of special characters to use. Must be at least 1 | `number` | `1` | no |
| <a name="input_min_upper"></a> [min\_upper](#input\_min\_upper) | Minimum number of uppercase characters to use. Must be at least 1 | `number` | `1` | no |
| <a name="input_number"></a> [number](#input\_number) | Whether to use numbers | `bool` | `true` | no |
| <a name="input_override_special"></a> [override\_special](#input\_override\_special) | Supply your own list of special characters to use for string generation | `string` | `"!@#$%&*()-_=+[]{}<>:?"` | no |
| <a name="input_secret_description"></a> [secret\_description](#input\_secret\_description) | Set a description for the secret | `string` | `"A password created by Terraform"` | no |
| <a name="input_special"></a> [special](#input\_special) | Whether to use special characters | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | User-Defined tags | `map(string)` | `{}` | no |
| <a name="input_upper"></a> [upper](#input\_upper) | Whether to use uppercase characters | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_version"></a> [lambda\_version](#output\_lambda\_version) | The selected version of the Lambda code |
| <a name="output_lambda_version_info"></a> [lambda\_version\_info](#output\_lambda\_version\_info) | all information about the selected version of the Lambda code |
| <a name="output_result"></a> [result](#output\_result) | String result of Lambda execution |
| <a name="output_secret_arn"></a> [secret\_arn](#output\_secret\_arn) | ARN of the secret containing the password |
| <a name="output_secret_name"></a> [secret\_name](#output\_secret\_name) | Name of the secret containing the password |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## The Giants Underneath this Module
- [pre-commit.com](pre-commit.com)
- [terraform.io](terraform.io)
- [github.com/tfutils/tfenv](github.com/tfutils/tfenv)
- [github.com/segmentio/terraform-docs](github.com/segmentio/terraform-docs)
