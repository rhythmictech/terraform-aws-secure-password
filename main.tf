locals {
  lambda_repo_full_name = "${local.lambda_repo_owner}/${local.lambda_repo_name}"
  lambda_repo_owner     = "rhythmictech"
  lambda_repo_name      = "lambda-aws-secure-password"
}

module "lambda_version" {
  source  = "rhythmictech/find-release-by-semver/github"
  version = "~> 1.1"

  repo_name          = local.lambda_repo_name
  repo_owner         = local.lambda_repo_owner
  version_constraint = var.lambda_version_constraint
}

locals {
  lambda_version     = module.lambda_version.target_version
  lambda_version_tag = module.lambda_version.version_info.release_tag
  zipfile            = "lambda-${local.lambda_version}.zip"
}

resource "null_resource" "lambda_zip" {
  triggers = {
    on_version_change = local.lambda_version
  }

  provisioner "local-exec" {
    command = "curl -LsSfo ${local.zipfile} https://github.com/${local.lambda_repo_full_name}/releases/download/${local.lambda_version_tag}/lambda.zip"
  }
}

data "external" "sha" {
  program = [
    "${path.module}/getsha.sh"
  ]

  query = {
    repo_full_name = local.lambda_repo_full_name
    tag            = local.lambda_version_tag
  }
}

data "aws_iam_policy_document" "assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name_prefix = "${var.name}-"
  description = "Role for ${var.name} to create secret"

  assume_role_policy = data.aws_iam_policy_document.assume.json
  tags               = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "secret_write" {
  statement {
    actions = [
      "secretsmanager:UpdateSecret",
      "secretsmanager:PutSecretValue"
    ]

    resources = [
      aws_secretsmanager_secret.this.arn
    ]
  }
}

resource "aws_iam_role_policy" "secret_write" {
  name_prefix = "${var.name}-secret-write-"
  policy      = data.aws_iam_policy_document.secret_write.json
  role        = aws_iam_role.this.name
}

resource "aws_lambda_function" "this" {
  description      = "Uses ${local.lambda_repo_name} version ${local.lambda_version} to generate a random password and save it to a SecretsManager Secret"
  filename         = local.zipfile
  function_name    = var.name
  handler          = "index.handler"
  role             = aws_iam_role.this.arn
  runtime          = "nodejs12.x"
  source_code_hash = data.external.sha.result.sha

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    }
  )

  lifecycle {
    ignore_changes = [
      last_modified
    ]
  }

  depends_on = [
    null_resource.lambda_zip
  ]
}

resource "aws_secretsmanager_secret" "this" {
  name_prefix = "${var.name}-"
  description = var.secret_description
  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

locals {
  password_params = {
    length             = var.length
    upper              = var.upper
    min_upper          = var.min_upper
    lower              = var.lower
    min_lower          = var.min_lower
    number             = var.number
    min_numeric        = var.min_numeric
    special            = var.special
    min_special        = var.min_special
    override_special   = var.override_special
    secret_name        = aws_secretsmanager_secret.this.name
    secret_description = var.secret_description
  }
}

# # Using a random_string as a trigger for when the password should be re-created.
# # This allows the Terraform re-creation logic to be duplicated exactly.
resource "random_string" "trigger" {
  keepers          = var.keepers
  length           = var.length
  lower            = var.lower
  min_lower        = var.min_lower
  min_numeric      = var.min_numeric
  min_special      = var.min_special
  min_upper        = var.min_upper
  number           = var.number
  override_special = var.override_special
  special          = var.special
  upper            = var.upper
}

module "lambda_invocation" {
  source  = "matti/resource/shell"
  version = "~>1.0.7"

  command = "aws lambda invoke --function-name ${aws_lambda_function.this.function_name} --payload '${jsonencode(local.password_params)}' ${path.module}/tmp/lambda_invocation_output"
  trigger = random_string.trigger.result

  depends = [
    aws_lambda_function.this.arn,
    aws_secretsmanager_secret.this
  ]
}

# must use a managed resource rather than a data resource here as a data resource triggers on every run
module "lambda_invocation_result" {
  source  = "matti/resource/shell"
  version = "~>1.0.7"

  command     = "cat ${path.module}/tmp/lambda_invocation_output"
  depends     = [module.lambda_invocation]
  trigger     = module.lambda_invocation.id
  working_dir = path.module
}
