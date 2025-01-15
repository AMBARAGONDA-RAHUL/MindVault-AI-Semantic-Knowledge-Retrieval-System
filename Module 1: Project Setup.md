# 📦 **Module 1: Project Setup**

This module covers installing necessary tools, setting up **Minikube with Docker**, and verifying the environment for deploying a baremetal Kubernetes cluster.

---

## 🔧 **Step 1: Install Required Tools**

### 1. **Install Docker**

Ensure Docker is installed and running:

- **Ubuntu/Linux:**

  ```bash
  sudo apt update
  sudo apt install -y docker.io
  sudo systemctl start docker
  sudo systemctl enable docker
  ```

- **Windows/Mac:**
  - Download and install Docker Desktop from [Docker Official Site](https://www.docker.com/products/docker-desktop).
  - Enable **Kubernetes** in Docker Desktop settings if prompted.

### 2. **Install Minikube**

- Download Minikube:

  ```bash
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
  ```

- Verify installation:

  ```bash
  minikube version
  ```

### 3. **Install Kubectl (Kubernetes CLI)**

- Install the latest version of kubectl:

  ```bash
  sudo apt-get install -y apt-transport-https ca-certificates curl
  sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
  echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo apt-get update
  sudo apt-get install -y kubectl
  ```

- Verify kubectl installation:

  ```bash
  kubectl version --client
  ```

---

## 🚀 **Step 2: Start Minikube with Docker Driver**

1. **Start Minikube Cluster:**

   ```bash
   minikube start --driver=docker
   ```

2. **Verify Minikube Status:**

   ```bash
   minikube status
   ```

---

## 📂 **Step 3: Configure Minikube Environment**

1. **Set up Docker environment for Minikube:**

   ```bash
   eval $(minikube -p minikube docker-env)
   ```

2. **Check Running Nodes:**

   ```bash
   kubectl get nodes
   ```

---

## 🛠️ **Step 4: Deploy a Sample Application (Optional)**

1. **Create a Deployment:**

   ```bash
   kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4
   ```

2. **Expose the Deployment:**

   ```bash
   kubectl expose deployment hello-minikube --type=NodePort --port=8080
   ```

3. **Check Service URL:**

   ```bash
   minikube service hello-minikube
   ```

---

## ✅ **Step 5: Verify Deployment**

Check that the service is running and accessible:

- Visit the URL provided by `minikube service hello-minikube` in a browser to see the application response.

---

## 📜 **Notes:**

- To stop the Minikube cluster:

  ```bash
  minikube stop
  ```

- To delete the cluster:

  ```bash
  minikube delete
  ```

---

This setup ensures a fully operational Kubernetes cluster using Minikube on Docker, ideal for development and testing environments.
