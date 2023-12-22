variable "project_id" {
  description = "GCP Project ID"
}

variable "region" {
  description = "GCP Region"
  default = "us-west1"
}

variable "credentials_file" {
    description = "Project Service Account credentials file"
}

variable "gke_username" {
  default     = ""
  description = "GKE username"
}

variable "gke_password" {
  default     = ""
  description = "GKE password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "Number of GKE nodes"
}
