# CI/CD Automation for Amazon EKS using Terraform, GitHub Actions & Karpenter
# Project Overview

<!-- This project demonstrates a production-oriented DevOps implementation for deploying a containerized microservice on Amazon EKS using Infrastructure as Code (IaC) and a fully automated CI/CD pipeline. -->

<!-- The solution provisions a private, secure Kubernetes platform and deploys a sample Node.js microservice with dynamic autoscaling and centralized logging, following real-world enterprise DevOps practices. -->

# Business Purpose of the Solution

The primary objective of this assignment is to showcase how a modern organization can:

- Provision cloud infrastructure reliably using Terraform

- Deploy applications to Kubernetes using CI/CD automation

- Achieve cost-efficient autoscaling using Karpenter

- Centralize application and cluster logs using EFK (Elasticsearch, Fluent Bit, Kibana)

- Maintain security, scalability, and operational visibility in production environments


# High-Level Architecture Explanation

The solution follows a GitOps-style workflow:

- Infrastructure is provisioned using Terraform with a remote S3 backend and DynamoDB locking

- Application code is containerized and pushed to Amazon ECR

- Kubernetes manifests are applied to an Amazon EKS cluster

- Karpenter dynamically provisions compute capacity based on workload demand

- EFK stack aggregates and visualizes application and cluster logs

- All resources are deployed inside a private VPC, ensuring controlled network access.

# Architecture Diagram (Textual Explanation)
# Networking:

- A private VPC with public and private subnets

- EKS worker nodes run only in private subnets

- Controlled outbound access via NAT Gateway

- Security Groups and NACLs enforce traffic boundaries

# Compute:

- Amazon EKS control plane (managed)

- Initial managed node group for bootstrap

- Karpenter-managed nodes for on-demand scaling

- Kubernetes HPA for pod-level scaling

# Security:

- IAM roles with least-privilege policies

- OIDC integration between EKS and AWS IAM

- No long-lived credentials inside the cluster

- Secrets managed via Kubernetes (no hard-coded secrets)

# Observability:

- Fluent Bit collects container logs

- Elasticsearch stores logs

- Kibana provides visualization and search

- Kubernetes metrics used for autoscaling

# Technology Stack:-
- Cloud Services

    - Amazon VPC

    - Amazon EKS

    - Amazon ECR

    - Amazon S3

    - Amazon DynamoDB - optional

    - AWS IAM

- DevOps & IaC Tools

    - Terraform

    - Docker

    - Kubernetes

    - Karpenter

    - Helm (for add-ons)

    - CI/CD Tools

    - GitHub Actions

- Monitoring & Logging

    - Fluent Bit

    - Elasticsearch

    - Kibana

    - Kubernetes Metrics Server 

# Key Design Decisions
- Terraform with Remote Backend

- Ensures state consistency

- Prevents concurrent modifications

- Enables safe CI/CD execution

- Immutable Docker Images

- Images are tagged using Git commit SHA

- Eliminates ambiguity caused by latest tags

- Fixed ECR Repository

- Repository created and managed by Terraform

- CI/CD pipeline references a deterministic repository name

- Avoids fragile cross-step dependencies

- Karpenter for Autoscaling

- Node-level autoscaling is faster and more cost-efficient than managed node groups alone

- Automatically selects optimal instance types

# Prerequisites
- Accounts & Access

- AWS account with EKS-level permissions

- GitHub repository access

- Local Tools

- Terraform ≥ 1.x

- Docker

- AWS CLI ≥ v2

- kubectl

# GitHub Secrets (Required)
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_ACCOUNT_ID
- AWS_REGION

# How to Run / Deploy (Step-by-Step)
1. Clone the Repository
    - git clone https://github.com/abhishekbhatt948/Terraform-EKS-Karpenter-App-Deployment.git
    - cd Terraform-EKS-Karpenter-App-Deployment

2. Configure GitHub Secrets

    - Add all required AWS secrets in GitHub → Repository → Settings → Secrets and variables → Actions.

3. Initialize Terraform Backend first (One-Time)

    - Run the terraform-backend GitHub Actions workflow to create:

    - S3 bucket for Terraform state

    - DynamoDB table for state locking

    This step is mandatory before running the main pipeline.

4. Trigger CI/CD Pipeline

    - Push code to the repository:

    - git push origin main


    # Pipeline actions:

    - Provision infrastructure

    - Build Docker image

    - Push image to ECR

    - Deploy application to EKS

5. Access the Cluster (Optional)
    - aws eks update-kubeconfig --name eks-demo --region ap-south-1

6. Access Application and Kibana
    - kubectl port-forward svc/demo-nodejs-app 8080:80 -n app
    - kubectl port-forward svc/kibana 5601:5601 -n logging

# CI/CD Pipeline Flow

- Source

    Git push triggers GitHub Actions

- Build

    Docker image built from app/

    Tagged with commit SHA

- Security

    IAM access via GitHub secrets

    No credentials stored in code

- Deploy

    Terraform applies infrastructure

    Kubernetes manifests applied via kubectl

    Security Considerations

    Private VPC and private worker nodes

    IAM roles with minimal permissions

    OIDC-based authentication for Kubernetes

    No secrets committed to source control

    Manual destroy workflow to prevent accidental deletion

    Scalability & High Availability

    Horizontal Pod Autoscaler scales pods

    Karpenter scales nodes dynamically

    Multi-AZ EKS deployment

    Stateless application design

    Monitoring & Logging

    Centralized log aggregation via EFK

    Pod-level and node-level visibility

    Kubernetes metrics for autoscaling decisions

- Cleanup / Teardown

    Infrastructure destruction is manual by design.

    - Steps:

    Trigger terraform-destroy GitHub Actions workflow

    Explicit approval required

    All AWS resources are safely removed

# Assumptions & Limitations:

- Sample application is non-production

- TLS termination and ingress controllers are out of scope

- No WAF or advanced security scanning implemented

- Single-environment (no multi-account strategy)

# Future Improvements:

- Add Ingress Controller with TLS

- Integrate Prometheus & Grafana

- Implement image vulnerability scanning

- Add canary or blue-green deployments

- Multi-environment Terraform workspaces

- AWS Secrets Manager integration

# Outcome

✔ Fully automated CI/CD pipeline
✔ Production-grade IaC implementation
✔ Secure and scalable Kubernetes platform