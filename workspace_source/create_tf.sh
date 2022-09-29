cat <<EOT >> main.tf
resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 1"
  }
}
EOT
