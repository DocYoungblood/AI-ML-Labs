#!/bin/bash

# Host File Entries
echo "192.168.7.4	ub01.k8s.local UB01" | sudo tee -a /etc/hosts
echo "192.168.7.5	ub02.k8s.local UB02" | sudo tee -a /etc/hosts
echo "192.168.7.6	ub03.k8s.local UB03" | sudo tee -a /etc/hosts

sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo modprobe br_netfilter

sudo sysctl --system

sudo apt update

sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

sudo rm -f /etc/apt/trusted.gpg.d/docker.gpg
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
 
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update

sudo apt install -y containerd.io

containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

sudo systemctl restart containerd
sudo systemctl enable containerd

sudo rm -f /etc/apt/trusted.gpg.d/apt-key.gpg
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo apt-add-repository -y "deb http://apt.kubernetes.io/ kubernetes-xenial main"


sudo apt update

sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


