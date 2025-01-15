## Module 2: Kubernetes Cluster Configuration

### Introduction

In this module, we will configure your Kubernetes cluster. This includes initializing the control plane, setting up the network plugin, and joining the worker nodes to the cluster. These steps are critical for ensuring that your cluster is secure, scalable, and ready for hosting game servers and DevOps automation workflows.

---

### 1. Initialize Kubernetes Control Plane 🌐

The first step in configuring your Kubernetes cluster is to initialize the control plane on your master node.

#### Step 1: Initialize Kubernetes Control Plane

Run the following command to initialize the Kubernetes control plane. This command will set up the control plane and configure the network CIDR for pod networking:

```bash
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
```

#### Step 2: Set Up `kubectl` for the Admin User

After initializing the control plane, configure `kubectl` to access the cluster from your master node:

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

This will allow you to run `kubectl` commands on the control plane node to manage the cluster.

---

### 2. Set Up Network Plugin (Calico) 📡

Kubernetes requires a network plugin to manage pod-to-pod communication. In this project, we will use **Calico**, a popular and powerful network plugin.

#### Step 1: Apply Calico Network Plugin

To set up Calico, run the following command to apply the Calico manifest from the official Kubernetes repository:

```bash
kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
```

This will configure the necessary networking components and allow pods to communicate across nodes in your Kubernetes cluster.

---

### 3. Join Worker Nodes 🖧

After setting up the control plane and network plugin, it's time to join the worker nodes to your Kubernetes cluster. This will allow your worker nodes to run game servers and other workloads.

#### Step 1: Generate Join Command

On the control plane node, run the following command to generate a unique token and discovery information for joining worker nodes:

```bash
kubeadm token create --print-join-command
```

This command will output a join command that looks something like this:

```bash
kubeadm join <control-plane-ip>:6443 --token <token> --discovery-token-ca-cert-hash <hash>
```

#### Step 2: Join Worker Nodes

On each worker node, run the join command generated in the previous step. This will add the worker nodes to the cluster and allow them to run workloads.

```bash
sudo <join-command>
```

Verify the nodes are successfully joined by running the following command on the control plane node:

```bash
kubectl get nodes
```

You should see all your nodes listed in the `Ready` state.

---

## Conclusion

Now that your Kubernetes control plane is set up, network plugin is installed, and worker nodes are successfully joined to the cluster, you're ready to proceed with setting up GitOps, CI/CD pipelines, and deploying game servers.

For troubleshooting or further assistance, feel free to check the Kubernetes documentation or refer to the issues section of this repository.

---

## Next Steps

Proceed to [Module 3: GitOps CI/CD Pipeline Setup](#module-3-gitops-cicd-pipeline-setup) to configure the CI/CD pipeline for automated deployments and security scans.

