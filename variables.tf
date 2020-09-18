
variable "name" {
  description = "Moniker to apply to all resources in the module"
  type        = string
}

variable "secret_description" {
  default     = "A password created by Terraform" #tfsec:ignore:GEN001
  description = "Set a description for the secret"
  type        = string
}

variable "tags" {
  default     = {}
  description = "User-Defined tags"
  type        = map(string)
}

variable "lambda_version_constraint" {
  default     = "^1.0.0-rc1"
  description = "NPM-style version constraint for the version of the lambda code you want to use"
  type        = string
}

variable "length" {
  description = "Length of the password to be created"
  type        = number
}

variable "lower" {
  default     = true
  description = "Whether to use lower case characters"
  type        = bool
}

variable "min_lower" {
  default     = 0
  description = "Minimum number of lowercase letters"
  type        = number
}

variable "number" {
  default     = true
  description = "Whether to use numbers"
  type        = bool
}

variable "min_numeric" {
  default     = 1
  description = "Minimum number of numeric characters to use. Must be at least 1"
  type        = number
}

variable "special" {
  default     = true
  description = "Whether to use special characters"
  type        = bool
}

variable "min_special" {
  default     = 1
  description = "Minimum number of special characters to use. Must be at least 1"
  type        = number
}

variable "override_special" {
  default     = "!@#$%&*()-_=+[]{}<>:?"
  description = "Supply your own list of special characters to use for string generation"
  type        = string
}

variable "upper" {
  default     = true
  description = "Whether to use uppercase characters"
  type        = bool
}

variable "min_upper" {
  default     = 1
  description = "Minimum number of uppercase characters to use. Must be at least 1"
  type        = number
}

variable "keepers" {
  default     = {}
  description = "Arbitrary map of values that when changed will force a new password"
  type        = map(string)
}
