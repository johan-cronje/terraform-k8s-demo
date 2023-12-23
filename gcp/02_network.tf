# generate random pet name to be used as a unique identifier
resource "random_pet" "prefix" {}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${random_pet.prefix.id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${random_pet.prefix.id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}
