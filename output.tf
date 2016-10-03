output "Connection Details" {
  value = "Use the password in your registry_auth file as user `imgadm` to login to `https://${var.common_name}` (${digitalocean_droplet.registry.ipv4_address})\n"
}

output "Cert Requirements for Docker" {
  value = "To connect using the new certificate, add the ca.crt file to /etc/docker/certs.d/${var.common_name} and restart the Docker daemon.\n"
}
