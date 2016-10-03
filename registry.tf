provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_volume" "registry-data" {
    region      = "${var.region}"
    name        = "registry-data"
    size        = "${var.vol_size}"
    description = "Your Registry Data Volume"
}

resource "digitalocean_droplet" "registry" {
    image = "docker"
    name = "${var.common_name}"
    region = "${var.region}"
    size = "512mb"
    volume_ids = ["${digitalocean_volume.registry-data.id}"]
    ssh_keys = [
        "${var.ssh_fingerprint}"
    ]

    connection {
      user = "root"
      private_key = "${file(var.pvt_key)}"
    }

    provisioner "local-exec" {
      command = "chmod +x gen_keys.sh && ./gen_keys.sh"
    }

    provisioner "remote-exec" {
      inline = "mkdir certs && mkdir auth"
    }

    provisioner "file" {
      source = "ca.crt"
      destination = "certs/ca.crt"
    }

    provisioner "file" {
      source = "ca.key"
      destination = "certs/ca.key"
    }

    provisioner "remote-exec" {
      inline = [
                "mkfs.ext3 -F /dev/sda",
                "mkdir /registry-data && mount -t ext3 /dev/sda /registry-data && mkdir /registry-data/registry",
                "echo `docker run --entrypoint htpasswd registry:2 -Bbn imgadm ${file("registry_auth")}` > auth/htpasswd",
                "cd certs && openssl genrsa -out registry.key 2048",
                "openssl req -subj \"/C=US/ST=NY/L=Flavortown/O=Guy Fieri/OU=Development Registry/CN=${var.common_name}\" -new -key registry.key -out registry.csr",
                "openssl x509 -req -in registry.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out registry.crt -days 500 -sha256",
                "docker run -d -p 5000:5000 --restart=always --name registry -v /registry-data/registry:/var/lib/registry -v /root/certs:/certs -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/registry.crt -e REGISTRY_HTTP_TLS_KEY=/certs/registry.key -e \"REGISTRY_AUTH=htpasswd\" -e \"REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm\" -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd -v /root/auth:/auth registry:2"
                ]
    }
}
