# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location = var.region
  version_prefix = "1.27."
}

resource "google_container_cluster" "primary" {
  name     = "${random_pet.prefix.id}-gke"
  location = var.region

  # Node pool is required for cluster creation, so create a temporary smallest 
  # possible default node pool, and immediately delete it afterwards.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  
  version = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = random_pet.prefix.id
    }

    # node disk options
    disk_size_gb = 100
    disk_type = "pd-standard"

    # preemptible  = true
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${random_pet.prefix.id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
