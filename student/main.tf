variable "prefix" {
  type = string
}

variable "email" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "billing_account" {
  type = string
}

resource "random_id" "name" {
  byte_length = 3
  prefix      = var.prefix
}

resource "google_project" "project" {
  name            = random_id.name.hex
  project_id      = random_id.name.hex
  folder_id       = var.folder_id
  billing_account = var.billing_account
}

resource "google_project_service" "services" {
  project = google_project.project.project_id

  for_each = toset([
    "compute.googleapis.com",
    "iam.googleapis.com",
  ])
  service = each.value

  disable_on_destroy = false
}

resource "google_project_iam_member" "account" {
  project = google_project.project.project_id
  role    = "roles/editor"
  member  = "user:${var.email}"
}
