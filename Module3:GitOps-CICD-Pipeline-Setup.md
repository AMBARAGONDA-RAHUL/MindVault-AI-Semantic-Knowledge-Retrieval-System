## Module 3: GitOps CI/CD Pipeline Setup

### Introduction

In this module, we will set up a GitOps-based CI/CD pipeline using **GitLab** to automate the build, push, and deployment processes for your game server. Additionally, we will integrate **Trivy** for security scans during the build process. This will ensure that any vulnerabilities in your game server's container images are detected early.

---

### 1. Deploy GitLab Runner 🚀  

First, we need to deploy a **GitLab Runner** on our Kubernetes cluster to handle the CI/CD pipeline tasks.    

#### Step 1: Install GitLab Runner on Kubernetes

We will install the GitLab Runner as a Kubernetes deployment. To do this, run the following commands: 
 
```bash
kubectl apply -f https://gitlab.com/gitlab-org/ci-cd/gitlab-runner-kubernetes/raw/master/deployment.yaml
```

This will deploy the GitLab Runner into your Kubernetes cluster, where it will be responsible for running the pipeline jobs.

#### Step 2: Register GitLab Runner with Your GitLab Instance 
 
Once the runner is deployed, we need to register it with your GitLab instance. Run the following command to get the registration token:

```bash
kubectl logs -f -l app=gitlab-runner
```

The token will be shown in the logs. Copy the token and register the runner with the following command:

```bash
gitlab-runner register --url https://gitlab.com/ --registration-token <your-token> --executor kubernetes
```

This will link your GitLab Runner with your GitLab repository and configure it to use Kubernetes as the executor for pipeline jobs.

---

### 2. Configure CI/CD Pipeline 🛠️

Now that the GitLab Runner is ready, we will configure the pipeline in your GitLab repository. The pipeline will build a Docker image for the game server and push it to a container registry.

#### Step 1: Create `.gitlab-ci.yml` File

In the root of your repository, create a `.gitlab-ci.yml` file. This file will define the stages of the pipeline and the jobs within each stage.

```yaml
stages:
  - build
  - deploy

build_image:
  stage: build
  script:
    - docker build -t registry.gitlab.com/<project>/minecraft-server .
    - docker push registry.gitlab.com/<project>/minecraft-server

deploy_game_server:
  stage: deploy
  script:
    - kubectl apply -f kubernetes/deployment.yaml
```

#### Step 2: Define Kubernetes Deployment Configuration

In the repository, create a `kubernetes` folder and define your game server's deployment in the `deployment.yaml` file. This file will describe how to deploy the game server on Kubernetes.

Example `deployment.yaml` for a Minecraft server:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: minecraft-server
spec:
  replicas: 1
  selector:
    matchLabels:
      app: minecraft-server
  template:
    metadata:
      labels:
        app: minecraft-server
    spec:
      containers:
        - name: minecraft-server
          image: registry.gitlab.com/<project>/minecraft-server
          ports:
            - containerPort: 25565
```

---

### 3. Security Scans with Trivy 🛡️

To ensure the security of the Docker images, we will integrate **Trivy**, a simple and efficient container scanner that detects vulnerabilities.

#### Step 1: Add Trivy Scan to CI Pipeline

In the `.gitlab-ci.yml` file, add a job to scan the image for vulnerabilities before deploying it:

```yaml
stages:
  - build
  - scan
  - deploy

build_image:
  stage: build
  script:
    - docker build -t registry.gitlab.com/<project>/minecraft-server .
    - docker push registry.gitlab.com/<project>/minecraft-server

scan_image:
  stage: scan
  script:
    - apt-get update && apt-get install -y wget
    - wget https://github.com/aquasecurity/trivy/releases/download/v0.18.3/trivy_0.18.3_Linux-64bit.deb
    - dpkg -i trivy_0.18.3_Linux-64bit.deb
    - trivy image registry.gitlab.com/<project>/minecraft-server

deploy_game_server:
  stage: deploy
  script:
    - kubectl apply -f kubernetes/deployment.yaml
```

This will run Trivy on the Docker image and output any vulnerabilities found in the image. You can configure the job to fail if critical vulnerabilities are detected.

---

## Conclusion

Your GitOps CI/CD pipeline is now set up and ready to automate the building, scanning, and deployment of game servers. This process ensures that you can deploy game servers securely and efficiently. 

For troubleshooting or further assistance, feel free to check the GitLab and Trivy documentation or refer to the issues section of this repository.

---

## Next Steps

Proceed to [Module 4: Monitoring & Metrics](#module-4-monitoring--metrics) to set up monitoring and metrics for your Kubernetes cluster.

