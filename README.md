# 🚀 Hello World CI/CD with GitHub Actions & Kubernetes

A simple Node.js application demonstrating a complete CI/CD pipeline using **GitHub Actions**, **Docker**, and **Kubernetes**.

---

# 📌 Features

✅ Node.js sample application  
✅ Dockerized application  
✅ GitHub Actions CI/CD pipeline  
✅ Kubernetes Deployment & Service  
✅ Automated build and test pipeline  
✅ Containerized deployment workflow  

---

# 🛠️ Tech Stack

- Node.js
- Docker
- GitHub Actions
- Kubernetes
- Minikube

---

# 📂 Project Structure

```text
.
├── .github/workflows/
├── app.js
├── Dockerfile
├── k8s/
│   ├── deployment.yml
│   └── service.yml
├── package.json
├── package-lock.json
└── README.md
```

---

## ⚙️ Local Setup

### Clone Repository

```bash
git clone https://github.com/rohitb9980/Hello-world.git
cd Hello-world
```

### 📦 Install Dependencies

```bash
npm install
```

### ▶️ Run Application

```bash
npm start
```

Application runs on: `http://localhost:3000`

### 🧪 Run Tests

```bash
npm test
```

---

## 🐳 Docker Setup

### Build Docker Image

```bash
docker build -t hello-world-app:latest .
```

### Run Docker Container

```bash
docker run -p 3000:3000 hello-world-app:latest
```

---

## ☸️ Kubernetes Deployment

### Apply Deployment

```bash
kubectl apply -f k8s/deployment.yml
```

### Apply Service

```bash
kubectl apply -f k8s/service.yml
```

### 🔍 Verify Resources

```bash
kubectl get deployments
kubectl get pods
kubectl get svc
```

---

## ⚡ GitHub Actions Pipeline

The CI/CD pipeline automatically performs:

- Checkout source code
- Install dependencies
- Run unit tests
- Build Docker image
- Push Docker image
- Deploy application to Kubernetes

---

## 🌐 Kubernetes Architecture

```
GitHub Push
    ↓
GitHub Actions
    ↓
Docker Build
    ↓
Kubernetes Deployment
    ↓
Running Pods
    ↓
NodePort Service
```

---

## 📸 Demo

Application deployed successfully on Kubernetes using GitHub Actions CI/CD pipeline.

---

## 👨‍💻 Author

**Rohit Bondre**

- GitHub: [github.com/rohitb9980](https://github.com/rohitb9980)