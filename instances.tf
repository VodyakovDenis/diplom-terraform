resource "random_shuffle" "diplom-network-subnet-random" {
  input        = [yandex_vpc_subnet.diplom-network-subnet-a.id, yandex_vpc_subnet.diplom-network-subnet-a.id]
  result_count = 1
}

resource "yandex_compute_instance" "k8s-cluster" {
  for_each = toset(["k8s-node1", "k8s-node2", "k8s-node3"])

  name = each.key
  hostname = "${each.key}.diplom.local"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8tckeqoshi403tks4l" # ubuntu-2004
      size = "20"
    }
  }

  network_interface {
    subnet_id = random_shuffle.diplom-network-subnet-random.result[0]
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:${file("id_rsa.pub")}"
  }
}

output "cluster_ips" {
  value = {
    internal = values(yandex_compute_instance.k8s-cluster)[*].network_interface.0.ip_address
    external = values(yandex_compute_instance.k8s-cluster)[*].network_interface.0.nat_ip_address
  }
}
