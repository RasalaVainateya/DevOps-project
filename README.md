# 🚀 AmazonBooks DevOps Project

**AKS + Terraform + CI/CD + Blue-Green Deployment + Monitoring**

---

## 📌 Project Overview

This project demonstrates a complete **end-to-end DevOps pipeline** for deploying a full-stack application using modern cloud-native tools.

It includes:

* Infrastructure provisioning using **Terraform**
* CI/CD pipeline using **Azure DevOps**
* Containerization with **Docker**
* Deployment on **Azure Kubernetes Service (AKS)**
* **Blue-Green deployment strategy**
* Monitoring using **Prometheus & Grafana**

---

## 🏗️ Architecture Diagram

![Architecture](screenshots/architecture.png)

---

## 🔄 Architecture Flow (Step-by-Step)

```text
[Developer]
     ↓
Push Code → GitHub Repository
     ↓
Azure DevOps Pipeline Triggered
     ↓
────────────── CI STAGE ──────────────
Build Docker Images (Frontend + Backend)
     ↓
Push Images → Azure Container Registry (ACR)
     ↓
──────────── Terraform STAGE ────────────
Provision Infrastructure using Terraform
     ↓
Create:
  - Resource Group
  - AKS Cluster
  - Role Assignments (AcrPull)
     ↓
──────────── CD STAGE ──────────────
Deploy to AKS using Kubernetes Manifests
     ↓
Kubernetes Components:
  - Frontend (LoadBalancer)
  - Backend (ClusterIP)
  - MySQL (PVC - Persistent Storage)
     ↓
──────── Blue-Green Deployment ────────
Two versions running:
  - backend-blue / backend-green
  - frontend-blue / frontend-green
     ↓
Traffic Switching:
kubectl patch svc → switch between blue & green
     ↓
──────────── Monitoring ──────────────
Prometheus → Collect Metrics
Grafana → Dashboards & Visualization
```

---

## ⚙️ Tech Stack

| Category      | Tools               |
| ------------- | ------------------- |
| Cloud         | Azure (AKS, ACR)    |
| IaC           | Terraform           |
| CI/CD         | Azure DevOps        |
| Containers    | Docker              |
| Orchestration | Kubernetes          |
| Monitoring    | Prometheus, Grafana |

---

## 📂 Project Structure

```text
├── backend/
├── frontend/
├── Terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── K8s/
│   ├── backend-blue.yaml
│   ├── backend-green.yaml
│   ├── frontend-blue.yaml
│   ├── frontend-green.yaml
│   ├── mysql-deployment.yaml
│   ├── mysql-pvc.yaml
│   ├── backend-services.yaml
│   └── frontend-services.yaml
├── azure-pipelines.yml
└── README.md
```

---

## 🔄 CI/CD Pipeline

### ✅ Build Stage

* Build Docker images
* Push to Azure Container Registry

### ✅ Terraform Stage

* Provision AKS cluster
* Configure Azure resources

### ✅ Deployment Stage

* Deploy MySQL, Backend, Frontend to AKS

### ✅ Blue-Green Deployment

* Two environments: blue & green
* Switch traffic dynamically using Kubernetes services

---

## 🔁 Blue-Green Deployment

Traffic switching command:

```bash
kubectl patch svc backend -p '{"spec":{"selector":{"version":"green"}}}'
kubectl patch svc frontend -p '{"spec":{"selector":{"version":"green"}}}'
```

---

## 💾 Persistent Storage

* MySQL uses **Persistent Volume Claim (PVC)**
* Data stored using Azure Managed Disks
* Ensures data persistence across pod restarts

---

## 📊 Monitoring

Installed using Helm:

```bash
helm install monitoring prometheus-community/kube-prometheus-stack
```

Tools:

* Prometheus → Metrics collection
* Grafana → Visualization dashboards

---

## 🌐 Application Access

```text
Frontend → LoadBalancer → Public IP
```

Example:

```
http://<EXTERNAL-IP>
```

---

## 🧪 Useful Commands

```bash
kubectl get pods
kubectl get svc
kubectl get deployments
kubectl get pvc

# Check active version
kubectl get svc backend -o jsonpath='{.spec.selector.version}'
```

---

## 🚀 Key Features

* End-to-end CI/CD pipeline
* Infrastructure as Code
* Blue-Green deployment (zero downtime)
* Persistent storage with PVC
* Monitoring with Grafana dashboards

---

## 📈 Future Improvements

* Ingress + Domain + HTTPS
* Horizontal Pod Autoscaling (HPA)
* Logging (ELK stack)
* Alerting system

---

## 👨‍💻 Author

**Vainateya**

---

## ⭐ Support

If you like this project, give it a ⭐ on GitHub!
