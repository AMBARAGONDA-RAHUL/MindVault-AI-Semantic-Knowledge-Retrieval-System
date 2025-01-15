## Module 6: Security & Backup

### Introduction

In this final module, we will secure the Kubernetes cluster and game server deployments by scanning for vulnerabilities in containers and setting up automated backups for the game server data. Security and backup are crucial for ensuring the integrity and availability of the environment.

---

### 1. Container Security with Trivy 🔐

**Trivy** is a simple and comprehensive container scanner that helps identify vulnerabilities in container images. It can scan for vulnerabilities in the image dependencies, configurations, and runtime components.

#### Step 1: Install Trivy

To get started with **Trivy**, install it on your system:

```bash
sudo apt install -y apt-transport-https
curl -sfL https://github.com/aquasecurity/trivy/releases/download/v0.29.1/trivy_0.29.1_Linux-64bit.deb -o trivy.deb
sudo dpkg -i trivy.deb
```

#### Step 2: Scan the Docker Image

Before deploying any container, you should scan the image for vulnerabilities. Here’s how to use Trivy to scan your **Minecraft server** image:

```bash
trivy image <your-dockerhub-username>/minecraft-server
```

Trivy will provide a report detailing vulnerabilities detected in the image.

#### Step 3: Fix Vulnerabilities

Based on the findings from Trivy, you should patch any vulnerabilities in the Docker image. This may involve updating the base image, upgrading outdated dependencies, or applying security patches.

---

### 2. Backup with Velero 💾

Velero is a powerful tool for performing **backup** and **restore** operations in Kubernetes environments. It allows you to back up Kubernetes cluster resources and persistent volumes (PVs), which is essential for recovering from disasters and ensuring high availability.

#### Step 1: Install Velero

To install Velero on your Kubernetes cluster, follow these steps:

```bash
# Add the Velero repository
curl -sSL https://github.com/vmware-tanzu/velero/releases/download/v1.11.0/velero-v1.11.0-linux-amd64.tar.gz | tar -xz -C /tmp

# Move the Velero binary to a location in your PATH
sudo mv /tmp/velero-v1.11.0-linux-amd64/velero /usr/local/bin/

# Verify the installation
velero version
```

#### Step 2: Set Up Object Storage for Backups

Velero requires a cloud storage service for backing up persistent volumes. You can use **AWS S3**, **Google Cloud Storage**, or any other compatible service.

For example, to set up Velero with **AWS S3**, configure Velero to use your AWS credentials and set the backup location:

```bash
velero install \
  --provider aws \
  --bucket <your-s3-bucket-name> \
  --secret-file <your-aws-credentials-file> \
  --backup-location-config region=<aws-region>
```

#### Step 3: Create a Backup

Now that Velero is installed and configured, you can create a backup of your Kubernetes resources (including the game server's Persistent Volumes):

```bash
velero backup create minecraft-backup --include-namespaces <namespace> --wait
```

This will create a backup of your game server resources, including persistent volumes.

#### Step 4: Restore from Backup

In case of a failure, you can restore your game server and Kubernetes resources from the backup:

```bash
velero restore create --from-backup minecraft-backup
```

This will restore all resources, including persistent volumes, ensuring that your game server data is recovered.

---

### Conclusion

By implementing **container security** with **Trivy** and **backup** using **Velero**, you have enhanced the security and reliability of your Kubernetes-based game server deployment. These tools help prevent vulnerabilities in your containers and ensure that your data is protected and can be restored in case of disaster.

