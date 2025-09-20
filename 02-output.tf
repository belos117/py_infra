output "cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = module.kubernetes_cluster.name
}

output "kubeconfig" {
  description = "Kubeconfig file content for the cluster"
  value       = module.kubernetes_cluster.kube_config_raw
  sensitive   = true
}

output "oidc_provider_url" {
  description = "OIDC provider URL for the cluster"
  value       = module.kubernetes_cluster.oidc_issuer_url
}