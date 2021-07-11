output "ip" {
  value = kubernetes_service.web.status[0].load_balancer[0].ingress[0].ip
}