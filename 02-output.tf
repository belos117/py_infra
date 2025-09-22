output "kubeconfig" {
  description = "Kubeconfig file content for the cluster"
  value       = module.eks.kubeconfig
  sensitive   = true
}