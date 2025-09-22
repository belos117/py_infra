output "cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = module.eks.cluster_name
}

output "kubeconfig" {
  description = "Kubeconfig file content for the cluster"
  value       = module.eks.kube_config_raw
  sensitive   = true
}

output "oidc_provider_url" {
  description = "OIDC provider URL for the cluster"
  value       = module.eks.oidc_issuer_url
}