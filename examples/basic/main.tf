
module "example" {
  source = "../.."

  name = "test"
}

output "example" {
  value = module.example
}
