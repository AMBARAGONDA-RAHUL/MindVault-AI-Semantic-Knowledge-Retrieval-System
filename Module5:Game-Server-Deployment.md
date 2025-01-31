## Module 5: Game Server Deployment

### Introduction

In this module, we will deploy a **game server** in our Kubernetes cluster. We will walk through the process of creating a custom Docker image for the game server and then deploying it as a StatefulSet within the Kubernetes cluster for high availability and scaling.

---

### 1. Create Custom Docker Image 🎮

Before deploying the game server, we need to create a **custom Docker image** that packages the game server along with its dependencies.

#### Step 1: Create a `Dockerfile`

First, create a `Dockerfile` to define the image. Here's an example for a **Minecraft** server:

```dockerfile
# Use an official Ubuntu base image
FROM ubuntu:20.04

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
  openjdk-17-jre-headless \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Create a directory for the game server
WORKDIR /minecraft

# Download Minecraft server JAR file
RUN curl -O https://launcher.mojang.com/v1/objects/a9b1f6a542d0ad34f2420f8f7a5bb3c5453b2ff9/server.jar

# Accept EULA
RUN echo "eula=true" > eula.txt

# Expose default Minecraft port
EXPOSE 25565

# Start the server when the container runs
CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]
```

This `Dockerfile` installs Java (required for Minecraft), downloads the Minecraft server JAR, and exposes the default Minecraft port.

#### Step 2: Build the Docker Image

To build the Docker image for the game server, run the following command from the directory containing the `Dockerfile`:

```bash
docker build -t <your-dockerhub-username>/minecraft-server .
```

#### Step 3: Push the Docker Image to a Registry

Once the Docker image is built, push it to a Docker registry (like DockerHub or GitLab's container registry):

```bash
docker push <your-dockerhub-username>/minecraft-server
```

---

### 2. Deploy StatefulSets in Kubernetes 🗂️

Now that we have the custom Docker image for our game server, we can deploy it to our Kubernetes cluster as a **StatefulSet**. StatefulSets are ideal for applications like game servers because they manage stateful applications with persistent storage.

#### Step 1: Create a StatefulSet YAML

Create a file called `minecraft-statefulset.yaml` and define the StatefulSet resource in it. Here’s an example YAML file:

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: minecraft
spec:
  serviceName: "minecraft"
  replicas: 2
  selector:
    matchLabels:
      app: minecraft
  template:
    metadata:
      labels:
        app: minecraft
    spec:
      containers:
      - name: minecraft
        image: <your-dockerhub-username>/minecraft-server
        ports:
        - containerPort: 25565
        volumeMounts:
        - name: minecraft-data
          mountPath: /minecraft/data
  volumeClaimTemplates:
  - metadata:
      name: minecraft-data
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 10Gi
```

#### Step 2: Apply the StatefulSet Configuration

Apply the configuration to your Kubernetes cluster using `kubectl`:

```bash
kubectl apply -f minecraft-statefulset.yaml
```

This will create a StatefulSet named `minecraft` with two replicas and a persistent volume for storing game data.

#### Step 3: Expose the Game Server with a Service

Now that the game server is deployed, we need to expose it to external traffic. Create a service to expose the Minecraft game server on port 25565:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: minecraft
spec:
  selector:
    app: minecraft
  ports:
    - protocol: TCP
      port: 25565
      targetPort: 25565
  clusterIP: None  # Ensures that the service is headless (no load balancing)
```

Save this as `minecraft-service.yaml` and apply it:

```bash
kubectl apply -f minecraft-service.yaml
```

---

### Conclusion

You have now successfully deployed your **game server** to the Kubernetes cluster as a **StatefulSet**, ensuring high availability and persistent storage for the game data. The server is exposed through a **headless service**, allowing clients to connect directly to any of the running pods.

---

## Next Steps

Proceed to [Module 6: Security & Backup](#module-6-security--backup) to enhance the security and backup mechanisms of your game server deployment.

