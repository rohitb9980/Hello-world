# 🚀 Jenkins CI/CD with Minikube & Kubernetes

> A complete DevOps CI/CD project demonstrating automated deployment of a Node.js application to Kubernetes using Jenkins, Docker, and Minikube.

<div align="center">

![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=node.js&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Minikube](https://img.shields.io/badge/Minikube-183A61?style=for-the-badge&logo=kubernetes&logoColor=white)

</div>

---

## 📑 Table of Contents

- [✨ Features](#-features)
- [🛠️ Tech Stack](#-tech-stack)
- [📂 Project Structure](#-project-structure)
- [⚙️ Local Setup](#-local-setup)
- [🐳 Docker Setup](#-docker-setup)
- [☸️ Kubernetes Deployment](#-kubernetes-deployment)
- [⚡ Jenkins Pipeline](#-jenkins-pipeline)
- [🏗️ Architecture](#-architecture)
- [👨‍💻 Author](#-author)

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| ✅ **Jenkins Pipeline** | Automated CI/CD pipeline with multi-stage deployment |
| ✅ **Dockerized App** | Complete containerization of Node.js application |
| ✅ **Kubernetes Deployment** | Full K8s manifests with Deployment & Service |
| ✅ **Minikube Integration** | Local Kubernetes cluster setup & management |
| ✅ **Self-Healing Pods** | ReplicaSets with automatic pod recovery |
| ✅ **Docker Hub Integration** | Automated image pushing and pulling |
| ✅ **Infrastructure as Code** | Complete IaC with YAML configurations |

---

## 🛠️ Tech Stack

| Technology | Purpose |
|-----------|---------|
| **Node.js** | Runtime environment for the application |
| **Docker** | Container orchestration & image building |
| **Jenkins** | CI/CD pipeline automation |
| **Kubernetes** | Container orchestration platform |
| **Minikube** | Local Kubernetes cluster |
| **Docker Hub** | Container image registry |

---

## 📂 Project Structure

```
Hello-world/
├── 📄 Jenkinsfile              # Jenkins pipeline configuration
├── 📄 app.js                   # Node.js application
├── 📄 Dockerfile               # Docker container specification
├── 📄 package.json             # Node.js dependencies
├── 📄 package-lock.json        # Dependency lock file
├── 📄 README.md                # Project documentation
└── 📁 k8s/                     # Kubernetes manifests
    ├── deployment.yml          # Pod deployment configuration
    └── service.yml             # Kubernetes service definition
```

---

## ⚙️ Local Setup

### 1️⃣ Clone Repository

```bash
git clone https://github.com/rohitb9980/Hello-world.git
cd Hello-world
git checkout Task2
```

### 2️⃣ Install Dependencies

```bash
npm install
```

### 3️⃣ Run Application

```bash
npm start
```

📍 Application available at: **[http://localhost:3000](http://localhost:3000)**

### 4️⃣ Run Tests

```bash
npm test
```

---

## 🐳 Docker Setup

### Build Docker Image

```bash
docker build -t hello-world-app:latest .
```

### Start Minikube

```bash
minikube start --driver=docker
```

### Load Image into Minikube

```bash
minikube image load hello-world-app:latest
```

---

## ☸️ Kubernetes Deployment

### Apply Manifests

```bash
# Deploy application
kubectl apply -f k8s/deployment.yml

# Create service
kubectl apply -f k8s/service.yml
```

### Verify Deployment

```bash
# Check deployments
kubectl get deployments

# Check ReplicaSets
kubectl get rs

# List running pods
kubectl get pods

# List services
kubectl get svc
```

### Access Application

```bash
# Open service in browser
minikube service hello-world-app-service
```

---

## 🔄 Self-Healing Demo

Watch Kubernetes automatically recover pods:

```bash
# Watch pods in real-time
kubectl get pods -w

# Delete a pod (in another terminal)
kubectl delete pod <pod-name>

# Observe automatic recreation due to ReplicaSets (replicas: 2)
```

---

## ⚡ Jenkins Pipeline

The Jenkins pipeline automates the complete CI/CD workflow:

```
┌─────────────────┐
│ GitHub Push     │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ Checkout Code   │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ Install Deps    │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ Run Tests       │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ Build Image     │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ Push to Hub     │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ Deploy to K8s   │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ Verify Deploy   │
└─────────────────┘
```

### Pipeline Stages

| Stage | Action |
|-------|--------|
| 📌 **Checkout** | Fetch source code from GitHub |
| 📦 **Install** | Install Node.js dependencies |
| 🧪 **Test** | Run unit tests |
| 🏗️ **Build** | Create Docker image |
| 📤 **Push** | Push image to Docker Hub |
| 📥 **Load** | Load image into Minikube |
| 🚀 **Deploy** | Deploy to Kubernetes cluster |
| ✔️ **Verify** | Validate deployment health |

---

## 🏗️ Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                     GitHub Repository                        │
│                   (Source Code + Trigger)                    │
└───────────────────────────┬──────────────────────────────────┘
                            │
                            ↓
┌──────────────────────────────────────────────────────────────┐
│                    Jenkins Pipeline                          │
│            (Build, Test, Package, Deploy)                    │
└───────────────────────────┬──────────────────────────────────┘
                            │
                            ↓
┌──────────────────────────────────────────────────────────────┐
│                   Docker Registry                            │
│                  (Docker Hub Storage)                        │
└───────────────────────────┬──────────────────────────────────┘
                            │
                            ↓
┌──────────────────────────────────────────────────────────────┐
│              Minikube Kubernetes Cluster                      │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Deployment (hello-world-app)                          │ │
│  │  ┌──────────────┐    ┌──────────────┐                 │ │
│  │  │   Pod #1     │    │   Pod #2     │ (ReplicaSet=2) │ │
│  │  └──────────────┘    └──────────────┘                 │ │
│  └─────────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Service (NodePort:30000)                              │ │
│  │         ↓                                               │ │
│  │  External Access (localhost:30000)                     │ │
│  └─────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
```

---

## 📸 Demo Highlights

```
🎯 Key Features in Action:

✅ Jenkins automated deployment on every push
✅ Kubernetes self-healing with pod recreation
✅ ReplicaSets maintaining high availability (2 replicas)
✅ Minikube local Kubernetes cluster
✅ Dockerized deployment workflow with zero downtime
✅ Complete infrastructure as code (IaC)
```

---

## 👨‍💻 Author

<div align="center">

**Rohit Bondre**

[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/rohitb9980)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/rohitbondre)

*DevOps Engineer | Cloud Native Enthusiast | Container Orchestration Specialist*

</div>

---

<div align="center">

⭐ If you found this project helpful, please consider giving it a star!

</div>