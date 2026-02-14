**Railway Ticket Booking Application on AWS EKS**

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

Two-Tier Architecture
- Frontend service for user interaction
- Backend service for business logic and database operations
- Kubernetes-Based Deployment
- Applications deployed on AWS EKS
- Service-to-service communication using Kubernetes DNS
- Configuration and secrets managed using Kubernetes Secrets
- AWS infrastructure provisioned using Terraform
- Version-controlled, repeatable, and environment-agnostic setup

🔄 **CI/CD & Automation**

- Continuous Integration
- Automated build pipelines using Jenkins
- Docker images built, scanned, and pushed to a container registry
- Continuous Delivery
- Kubernetes deployments managed with Helm
- ArgoCD used for GitOps-based continuous delivery

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
  - VPC, Subnets, Route Tables, and Internet Gateway
  - EC2 (Ubuntu Jumpbox) for management access
  - Amazon RDS (MySQL) database
  - Amazon EKS Kubernetes cluster
  - Installs ArgoCD on the EKS cluster and integrates the Helm charts repository
  - Deploys the NGINX Ingress Controller and exposes services via an AWS Load Balancer
  - Maps the Load Balancer DNS to a GoDaddy-managed domain
  - Secures external access with TLS/HTTPS using cert-manager

 **Repository Structure**

This project follows a multi-repository approach:

- Application & Infrastructure Repository
- Frontend and backend application code
- Terraform scripts for AWS infrastructure provisioning
- Helm Charts Repository
- Helm charts used for deploying applications to EKS


**Final Output:**
A fully deployed Railway Ticket Booking app accessible via a custom domain over HTTPS, running on scalable kubernetes infrastruture on AWS!
