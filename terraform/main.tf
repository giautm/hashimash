provider "google" {
  project     = var.gcp_project_id
  credentials = file(var.gcp_service_account)
  region      = var.gcp_region_id
  zone        = var.gcp_zone_id
}

provider "kubernetes" {
  host                   = module.gcp.google_container_cluster.endpoint
  username               = module.gcp.google_container_cluster.master_auth.0.username
  password               = module.gcp.google_container_cluster.master_auth.0.password
  client_certificate     = base64decode(module.gcp.google_container_cluster.master_auth.0.client_certificate)
  client_key             = base64decode(module.gcp.google_container_cluster.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(module.gcp.google_container_cluster.master_auth.0.cluster_ca_certificate)
}

module "gcp" {
  source = "./modules/gcp"
  region = var.gcp_region_id
  zone   = var.gcp_zone_id
}

module "consul" {
  source = "./modules/consul"

  kubeconfig_created = module.gcp.kubeconfig_created
}

module "vault" {
  source = "./modules/vault"

  kubeconfig_created = module.gcp.kubeconfig_created
}

module "sensors" {
  source = "./modules/sensors"
  zone   = var.gcp_zone_id

  consul_ext_ip = module.gcp.consul_ext_ip
}

module "api" {
  source = "./modules/api"

  gcp_project_id = var.gcp_project_id
}

module "web" {
  source = "./modules/web"

  gcp_project_id = var.gcp_project_id
}

output "web-ui" {
  value = module.web.ip
}