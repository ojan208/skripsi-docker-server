provider "google" {
    project     = "extreme-battery-426200-u1"
    region		= "asia-southeast2"
}

resource "google_compute_instance" "master-server" {
    name            = "master-server"
    machine_type    = "e2-standard-2"
    zone            = "asia-southeast2-a"
    tags            = [ "minecraft" ]

    boot_disk {
        initialize_params {
          image = "projects/debian-cloud/global/images/debian-12-bookworm-v20250415"
          type = "pd-ssd"
		  size = 10
        }
    }

    network_interface {
		network = "default"
		access_config {
		  network_tier = "PREMIUM"
		}
    }

	# install git, java, and tcpdump
	metadata_startup_script = <<-EOF
	sudo apt-get update
	sudo apt-get install -y git default-jre tcpdump
	git clone https://github.com/ojan208/skripsi-docker-server.git /home/skripsi-docker-server
	sudo tcpdump -w /home/worker-2-captured_packets.pcap tcp &
	cd /home/skripsi-docker-server/master
	nohup java -jar multipaper-master-2.12.3-all.jar &
	EOF
}

# data "google_compute_instance" "master-server" {
# 	name 		= "master-server"
# 	zone 		= "asia-southeast2-a"
#     project     = "extreme-battery-426200-u1"

# 	depends_on = [ 
# 		google_compute_instance.master-server
# 	]
# }

resource "google_compute_instance" "worker-1" {
	name = "worker-1"
	machine_type = "e2-standard-2"
	zone = "asia-southeast2-a"
	tags = [ "minecraft" ]

	boot_disk {
		initialize_params {
			image = "projects/debian-cloud/global/images/debian-12-bookworm-v20250415"
			type = "pd-ssd"
			size = 10
		}
  	}

	network_interface {
		network = "default"
		access_config {
			network_tier = "PREMIUM"
		}
	}

	# install git, java, and tcpdump
	metadata_startup_script = <<-EOF
	sudo apt-get update
	sudo apt-get install -y git default-jre tcpdump
	git clone https://github.com/ojan208/skripsi-docker-server.git /home/skripsi-docker-server
	sudo tcpdump -w /home/worker-2-captured_packets.pcap tcp &
	cd /home/skripsi-docker-server/worker 
	chmod +x run_server.sh
	nohup ./run_server.sh worker-1 ${google_compute_instance.master-server.network_interface.0.network_ip}:35353 &
	EOF

	depends_on = [ 
		google_compute_instance.master-server
	]
}

resource "google_compute_instance" "worker-2" {
	name = "worker-2"
	machine_type = "e2-standard-2"
	zone = "asia-northeast1-a"
	tags = [ "minecraft" ]

	boot_disk {
		initialize_params {
			image = "projects/debian-cloud/global/images/debian-12-bookworm-v20250415"
			type = "pd-ssd"
			size = 10
		}
  	}

	network_interface {
		network = "default"
		access_config {
			network_tier = "PREMIUM"
		}
	}

	# install git, java, and tcpdump
	metadata_startup_script = <<-EOF
	sudo apt-get update
	sudo apt-get install -y git default-jre tcpdump
	git clone https://github.com/ojan208/skripsi-docker-server.git /home/skripsi-docker-server
	sudo tcpdump -w /home/worker-2-captured_packets.pcap tcp &
	cd /home/skripsi-docker-server/worker 
	chmod +x run_server.sh
	nohup ./run_server.sh worker-2 ${google_compute_instance.master-server.network_interface.0.network_ip}:35353 &
	EOF

	depends_on = [ 
		google_compute_instance.master-server
	]
}