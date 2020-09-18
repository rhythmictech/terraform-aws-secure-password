module "secure_password" {
  source  = "rhythmictech/secure-password/aws"
  version = "~> 1.0.0-rc1"

  name   = "my-secure-pass"
  length = 24
}

output "secret_name" {
  value = module.secure_password.secret_name
}
