variable "google_project_id" {
  type = string
}

variable "gcp_region_id" {
  type    = string
  default = "asia-southeast1"
}

variable "gcp_zone_id" {
  type    = string
  default = "asia-southeast1-a"
}

variable "gcp_service_account_path" {
  type = string
}
