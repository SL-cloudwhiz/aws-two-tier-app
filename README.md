# Railway Ticket Booking Application on AWS EKS


<img width="1536" height="1024" alt="architecture" src="https://github.com/user-attachments/assets/7921b20b-3bb5-4460-acaa-10d6a1a182c7" />


This project illustrates the deployment of a two-tier web application on AWS Elastic Kubernetes Service (EKS) using modern DevOps tools and best practices.
It showcases how frontend and backend services can be containerized, orchestrated, and deployed in a scalable and secure Kubernetes environment.

Key focus areas: automation, infrastructure as code, and continuous delivery.

📌 **Project Overview**

Railway Ticket Booking Application implements the following workflow:

- Users submit booking details (Name, Source, Destination, and Preference) through a web-based frontend
- Frontend communicates with the backend API using Kubernetes service discovery
- Backend processes requests and securely stores booking data in an AWS RDS MySQL database
- All components are fully containerized and deployed on Kubernetes following cloud-native design principles.

🏗 **Architecture Highlights**

- **Two-Tier Architecture:** Frontend handles user interaction while the backend manages business logic and database operations.
- **Kubernetes Deployment:** Application deployed on AWS EKS with service-to-service communication via Kubernetes DNS and configuration managed using Kubernetes Secrets.
- **Infrastructure as Code:** AWS infrastructure provisioned using Terraform for a version-controlled and environment-agnostic setup.

🔄 **CI/CD & Automation**

- **Continuous Integration:** Jenkins pipelines automate building, scanning, and pushing Docker images to a container registry.
- **Continuous Delivery:** Helm manages Kubernetes deployments while ArgoCD enables GitOps-based continuous delivery.

🌐 **Jenkins Pipeline Overview**

Pipeline 1: Application CI/CD

This pipeline handles the complete build, scan, and deployment workflow for the application:
- Pulls frontend and backend source code from GitHub
- Performs static code analysis using SonarQube
- Scans application dependencies with OWASP Dependency-Check
- Builds Docker images for both frontend and backend services
- Pushes container images to AWS Elastic Container Registry (ECR)
- Runs Trivy vulnerability scans on Docker images
- Clones the Helm charts repository and dynamically updates image tags
- Triggers deployment updates via ArgoCD using a GitOps workflow

Pipeline 2: Infrastructure Provisioning

This pipeline automates the end-to-end provisioning of cloud infrastructure:
- Provisions AWS infrastructure using Terraform, including:
  - VPC, Subnets, Route Tables, and Internet Gateway, EC2 (Ubuntu Jumpbox) for management access, RDS (MySQL) database and      EKS cluster
  - Installs ArgoCD on the EKS cluster and integrates the Helm charts repository
  - Deploys the NGINX Ingress Controller and exposes services via an AWS Load Balancer
  - Maps the Load Balancer DNS to a GoDaddy-managed domain
  - Secures external access with TLS/HTTPS using cert-manager

**Final Output:**
A fully deployed Railway Ticket Booking app accessible via a custom domain over HTTPS, running on scalable kubernetes infrastruture on AWS!

<img width="1891" height="982" alt="Screenshot 2026-02-25 082748" src="https://github.com/user-attachments/assets/80bd8013-975c-4af0-ba8d-19205d1a64b8" />
<img width="681" height="264" alt="Screenshot 2026-02-25 085246" src="https://github.com/user-attachments/assets/1f377215-754b-44eb-b121-2d74ce7a0c29" />

---

1. Create AWS Infra using Terraform: VPC, EC2, EKS, RDS

2. Connect to EC2 ( jump-server ) & Install kubectl, helm, awscli -> after provide aws creds on ec2 using "aws configure"

3. update RDS Endpoint on K8s -> backend-deployment.yaml -> DB_HOST

4. Create 2 ECR Repositorys Manually: 1. frontend-repo, 2. backend-repo

  - Now build frontend & backend Docker images and push to AWS ECR Repos:

  - login to AWS ECR

```
cd frontend
docker build -t frontend:latest
docker tag frontend:latest 657001761946.dkr.ecr.us-east-1.amazonaws.com/frontend-repo:latest
docker push 657001761946.dkr.ecr.us-east-1.amazonaws.com/frontend-repo:latest

cd backend
docker build -t backend:latest
docker tag backend:latest 657001761946.dkr.ecr.us-east-1.amazonaws.com/backend-repo:latest
docker push 657001761946.dkr.ecr.us-east-1.amazonaws.com/backend-repo:latest
```
5. Update Images on "K8s yamls" and also provide "rds database credentails" on backend-deployment.yaml & apply them
```
cd k8s
kubectl apply -f .
```
  - check "frontend & backend service are running or not"

`kubectl get all`

6. access "frontend ui" using "LoadBalancer" DNS Name & provide inputs like "Name, Travelling from, Destination, Seat Preference" & check all the data on "backend"
<img width="1891" height="982" alt="Screenshot 2026-02-25 082748" src="https://github.com/user-attachments/assets/80bd8013-975c-4af0-ba8d-19205d1a64b8" />

  - Connect to ec2 ( jump server ) & Install MySQL and check your data
```
sudo apt install -y mysql-client
mysql -h <RDS-endpoint> -u sou -p
```
  - Example:
```
mysql -h my-rds-instance.ce9wya4k41zv.us-east-1.rds.amazonaws.com -u sou -p
password: Password123

show databases;
use appdb;
show tables;
```
select * from bookings;

<img width="681" height="264" alt="Screenshot 2026-02-25 085246" src="https://github.com/user-attachments/assets/1f377215-754b-44eb-b121-2d74ce7a0c29" />

7. To Destroy entire resources
`terraform destroy --auto-approve`
