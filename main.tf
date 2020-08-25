variable "folder_id" {
  type = string
}

variable "billing_account" {
  type = string
}

module "workshop" {
  source = "./student"

  billing_account = var.billing_account
  folder_id       = var.folder_id
  prefix          = "p20200825-"

  for_each = toset([
    "seth@sethvargo.com",
  ])

  email = each.value
}
