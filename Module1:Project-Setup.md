# Baremetal Kubernetes Cluster for Game Servers & DevOps Automation

This project is a step-by-step guide to deploying a secure, scalable Kubernetes cluster for hosting game servers and automating DevOps workflows using GitOps, CI/CD, and advanced monitoring techniques.

---
 
## **Module 1: Project Setup**          
 
### Introduction

In this module, we will guide you through the process of setting up the necessary software, configuring your Kubernetes cluster on bare metal, and preparing it for the next steps in the game server deployment and DevOps automation pipeline.

---
 
### 1. Install Required Software

Before we begin setting up Kubernetes, ensure that the required software is installed on all your nodes (control plane and worker nodes).

#### Step 1: Update System

First, update the system package lists to ensure you have the latest software repositories. 

```bash
sudo apt update
```

#### Step 2: Install Docker, Curl, and Apt Transport

Docker is the core containerization tool, and curl is used to fetch Kubernetes components. Install these with the following command:

```bash
sudo apt install -y docker.io curl apt-transport-https
```

#### Step 3: Enable Docker Service

Enable Docker to start automatically when your machine boots up:

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

---

### 2. Configure Static IPs and SSH Access

To ensure that your Kubernetes nodes can communicate with each other, set up static IPs for all your nodes. Additionally, you’ll need SSH access to manage the nodes remotely.

#### Step 1: Set Static IPs

On each of your control plane and worker nodes, configure static IP addresses. This can be done by editing the network configuration file. Example for Ubuntu:

```bash
sudo nano /etc/netplan/00-installer-config.yaml
```

Update the configuration to set a static IP for each node and apply the changes:

```bash
sudo netplan apply
```

#### Step 2: Enable SSH Access

Enable SSH access on each node to allow you to manage the cluster remotely. Run the following commands on each node:

```bash
sudo systemctl enable ssh
sudo systemctl start ssh
```

Test SSH access by logging into each node from another node:

```bash
ssh user@<node-ip-address>
```

---

### 3. Install Kubernetes Components

Now that the basic setup is complete, we will install Kubernetes on all your nodes. This includes the `kubeadm`, `kubelet`, and `kubectl` components.

#### Step 1: Add Kubernetes APT Repository

Kubernetes provides an official APT repository. Add it to your system:

```bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
```

#### Step 2: Update System Repositories

Now update your system repositories to include the Kubernetes package:

```bash
sudo apt update
```

#### Step 3: Install Kubernetes Components

Install the required Kubernetes components: `kubelet`, `kubeadm`, and `kubectl`:

```bash
sudo apt install -y kubelet kubeadm kubectl
```

#### Step 4: Hold Kubernetes Versions

To avoid upgrading these components during system updates, hold the Kubernetes package versions:

```bash
sudo apt-mark hold kubelet kubeadm kubectl
```

---

## Conclusion

At this point, you've set up the required software and configured your network for Kubernetes on bare metal. In the next module, you'll initialize the Kubernetes cluster control plane and begin configuring your cluster's network.

For troubleshooting or further assistance, feel free to check the Kubernetes documentation or refer to the issues section of this repository.

---

## Next Steps

Proceed to [Module 2: Kubernetes Cluster Configuration](#module-2-kubernetes-cluster-configuration) to initialize the Kubernetes control plane and join worker nodes to the cluster.

