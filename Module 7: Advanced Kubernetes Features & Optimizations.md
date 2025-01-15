## Module 7: Advanced Kubernetes Features & Optimizations

### Introduction

In this module, we will explore advanced Kubernetes features to optimize your game server cluster. These features help scale your infrastructure, manage resource utilization, and ensure proper scheduling of workloads.

---

### 1. Horizontal Pod Autoscaling 📈

**Horizontal Pod Autoscaling (HPA)** automatically adjusts the number of pod replicas in a deployment or replica set based on CPU utilization or other metrics.

#### Step 1: Enable Metrics Server

Before configuring HPA, you need to install and configure the **metrics server**. The metrics server collects resource usage data (e.g., CPU, memory) from the cluster and makes it available for scaling decisions.

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.6.1/components.yaml
```

#### Step 2: Create HPA for Game Server

Once the metrics server is running, create an HPA for your **Minecraft** server deployment to scale based on CPU utilization. You can adjust the `targetCPUUtilizationPercentage` as per your requirements.

```bash
kubectl autoscale deployment minecraft-server --cpu-percent=50 --min=1 --max=10
```

This will automatically scale the number of pods from 1 to 10 based on CPU utilization.

#### Step 3: Verify HPA

To check the status of your HPA, run the following command:

```bash
kubectl get hpa
```

The HPA will scale your game server pods up or down based on the CPU usage, ensuring efficient resource usage.

---

### 2. Resource Requests and Limits ⚙️

**Resource requests and limits** help you define the amount of CPU and memory your pods require and can use. This ensures that workloads are scheduled effectively and prevents resource contention.

#### Step 1: Define Resource Requests and Limits in Deployment YAML

In your **Minecraft server deployment**, you can specify resource requests and limits for CPU and memory.

Example of a deployment YAML with resource requests and limits:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: minecraft-server
spec:
  replicas: 2
  template:
    spec:
      containers:
      - name: minecraft
        image: registry.gitlab.com/<project>/minecraft-server
        resources:
          requests:
            memory: "512Mi"
            cpu: "500m"
          limits:
            memory: "1Gi"
            cpu: "1000m"
```

#### Step 2: Apply the YAML File

```bash
kubectl apply -f minecraft-deployment.yaml
```

With resource requests and limits set, Kubernetes ensures that your game server containers get the resources they need and limits them from exceeding the maximum resource utilization, preventing resource overuse.

---

### 3. Affinity and Taints 🖧

**Affinity** and **taints** help control the placement of pods within the Kubernetes cluster, allowing you to schedule pods on specific nodes based on labels or conditions.

#### Step 1: Define Affinity in Pod Specification

Affinity rules define the placement of pods relative to other pods or nodes. You can set **node affinity** to specify which nodes the pods should run on.

Example YAML with node affinity:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: minecraft-server
spec:
  replicas: 2
  template:
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                  - key: "kubernetes.io/hostname"
                    operator: In
                    values:
                      - node-1
                      - node-2
      containers:
        - name: minecraft
          image: registry.gitlab.com/<project>/minecraft-server
```

This will schedule the **Minecraft server** pods only on nodes `node-1` and `node-2`.

#### Step 2: Use Taints to Prevent Pods from Scheduling on Specific Nodes

You can use **taints** to prevent pods from being scheduled on certain nodes. For example, to prevent pods from being scheduled on `node-3`, apply a taint to that node:

```bash
kubectl taint nodes node-3 key=value:NoSchedule
```

To allow pods to be scheduled on tainted nodes, you can use **tolerations** in your pod specification.

Example YAML with toleration:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: minecraft-server
spec:
  replicas: 2
  template:
    spec:
      tolerations:
        - key: "key"
          operator: "Equal"
          value: "value"
          effect: "NoSchedule"
      containers:
        - name: minecraft
          image: registry.gitlab.com/<project>/minecraft-server
```

This toleration allows the pod to be scheduled on nodes with the specified taint.

---

### Conclusion

By implementing these advanced Kubernetes features—**Horizontal Pod Autoscaling**, **Resource Requests and Limits**, and **Affinity and Taints**—you can ensure that your game server deployment is both efficient and resilient, scaling automatically based on demand and optimizing resource usage across your Kubernetes cluster.

