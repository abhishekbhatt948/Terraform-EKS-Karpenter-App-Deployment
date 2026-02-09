<!-- # CI/CD Automation for EKS using Terraform, GitHub Actions & Karpenter

This repository demonstrates a fully automated CI/CD pipeline for deploying a containerized Node.js application to Amazon EKS, using Terraform for infrastructure provisioning and GitHub Actions for continuous delivery. -->

# Assignment :
- Create Private VPC,
- Create EKS-Cluster,
- Deploy sample micro-service in EKS,
- used karpenter for Auto Scaling,
- create EFK for logs

The solution follows real-world DevOps best practices:

NOTE: This Assignment is Design in Such a way by just minimal approach you can create full IaC with deploy App in EKS with Autoscaling feature.
      You Must Need Some Prerequivisite before apply such as: Terraform, Docker, AWS Config(Ac ID, Access Key ID, Acces Key Secret, Region) and for CI/CD Secret Variables for AWS. Variables should be set first in Github-Action before run Apply.

# How To Run:
- Git Pull Code from Repository : LINK: "https://github.com/abhishekbhatt948/Terraform-EKS-Karpenter-App-Deployment.git"
- Assume you set Github-Action Secret Variable if you want to go with same. OR you can run Terraform Code (Manually setup)
- On Push github Repo Github-Action Trigger and in Action first you must RUN - > Terraform Backend : for S3 + Dynamodb Setup otw pipeline failed.
- After Backend main Pipeline auto setup everything. (Build,Dockre Image, Push ECR, Deploy App)
- If You Want cluster Access from your Terminal you must Set Context first by cmd : "aws eks update-kubeconfig --name eks-demo --region ap-south-1" once context set you can check ky kubectl cmd.
- for Demo App Service should be Expose by cmd "kubectl port-forward *** " for both App and Kibana.
- once everything fine , in Github-Action Action run Terraform Destroy to Delete All Resource in AWS. 

Infrastructure as Code (IaC)

Immutable Docker images

Automated Kubernetes deployment

Safe Terraform state management

Scalable cluster using Karpenter

📌 Architecture Overview

Workflow sequence:

Terraform

Provisions AWS infrastructure:

VPC

EKS Cluster

ECR Repository

IAM roles

Karpenter (node autoscaling)

Uses S3 backend + DynamoDB locking for remote state

Docker

Application is containerized

Image is built and tagged with git commit SHA

Image is pushed to Amazon ECR

Kubernetes

Application is deployed to EKS

Rolling update strategy

HPA (Horizontal Pod Autoscaler) enabled

🗂 Repository Structure
G:.
├───.github
│   └───workflows/ci-cd.yaml  -  # Run Automation pipeline
                 / terraform-backend.yaml  # One time S3 + Dynamodb Backend Create
                 / terraform-destroy.yaml  # When Need Terraform Destroy
├───app   # Nodejs Demo App

├───k8s
│   ├───app/manifest*
│   └───hpa/manifest*
├───terraform
│   │   └───providers 
│   │                
│   └───modules
│       ├───aws-auth
│       ├───ecr
│       ├───efk
│       ├───eks
│       ├───karpenter
│       ├───nodegroup
│       └───vpc
└───terraform-backend

⚙️ Technologies Used

Cloud: AWS

Infrastructure: Terraform

Containerization: Docker

Orchestration: Kubernetes (EKS)

Autoscaling: Karpenter + HPA

CI/CD: GitHub Actions

Registry: Amazon ECR

🚀 CI/CD Pipeline Flow
1️⃣ Terraform – Infrastructure Provisioning

Initializes Terraform with remote backend

Applies infrastructure changes

Ensures idempotent execution (no duplicate infra)

2️⃣ Build & Push Docker Image

Builds Docker image from app/

Tags image with github.sha

Pushes image to fixed ECR repository

3️⃣ Deploy to EKS

Updates kubeconfig for EKS

Ensures Kubernetes namespace exists

Injects Docker image into manifest

Applies manifests using kubectl apply

🔐 Terraform State Management

Backend: Amazon S3

Locking: DynamoDB

Prevents:

Duplicate infrastructure

Concurrent state corruption

Accidental re-creation during CI/CD runs

📦 ECR Strategy (Design Decision)

ECR repository name is fixed and known

Terraform creates the repository

CI/CD references it deterministically

Reason:

ECR repository names are application identifiers and should remain stable to avoid fragile pipeline dependencies.

🧠 Key Design Decisions

Immutable images (no latest tag)

No Terraform output dependency in Docker steps

Idempotent Kubernetes deployment

Manual destroy workflow (safe teardown)

Namespace creation handled explicitly

🧪 Deployment Verification

After deployment, verify:

kubectl get pods -n app
kubectl get svc -n app
kubectl rollout status deployment/demo-nodejs-app -n app

🧹 Infrastructure Cleanup

Terraform destroy is intentionally not automatic.

To destroy infrastructure:

Use a manual GitHub Actions workflow

Requires explicit confirmation to avoid accidental deletion

📄 Prerequisites

AWS Account

EKS-compatible IAM permissions

GitHub repository secrets:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_ACCOUNT_ID

AWS_REGION

🎯 Outcome

✔ Fully automated CI/CD pipeline
✔ Production-grade Terraform setup
✔ Scalable Kubernetes cluster
✔ Reliable deployments
# CI/CD Automation for EKS using Terraform, GitHub Actions & Karpenter

This repository demonstrates a fully automated CI/CD pipeline for deploying a containerized Node.js application to Amazon EKS, using Terraform for infrastructure provisioning and GitHub Actions for continuous delivery.

# Assignment :
- Create Private VPC,
- Create EKS-Cluster,
- Deploy sample micro-service in EKS,
- used karpenter for Auto Scaling,
- create EFK for logs

The solution follows real-world DevOps best practices:

NOTE: This Assignment is Design in Such a way by just minimal approach you can create full IaC with deploy App in EKS with Autoscaling feature.
      You Must Need Some Prerequivisite before apply such as: Terraform, Docker, AWS Config(Ac ID, Access Key ID, Acces Key Secret, Region) and for CI/CD Secret Variables for AWS. Variables should be set first in Github-Action before run Apply.

# How To Run:
- Git Pull Code from Repository : LINK: "https://github.com/abhishekbhatt948/Terraform-EKS-Karpenter-App-Deployment.git"
- Assume you set Github-Action Secret Variable if you want to go with same. OR you can run Terraform Code (Manually setup)
- On Push github Repo Github-Action Trigger and in Action first you must RUN - > Terraform Backend : for S3 + Dynamodb Setup otw pipeline failed.
- After Backend main Pipeline auto setup everything. (Build,Dockre Image, Push ECR, Deploy App)
- If You Want cluster Access from your Terminal you must Set Context first by cmd : "aws eks update-kubeconfig --name eks-demo --region ap-south-1" once context set you can check ky kubectl cmd.
- for Demo App Service should be Expose by cmd "kubectl port-forward *** " for both App and Kibana.
- once everything fine , in Github-Action Action run Terraform Destroy to Delete All Resource in AWS. 

Infrastructure as Code (IaC)

Immutable Docker images

Automated Kubernetes deployment

Safe Terraform state management

Scalable cluster using Karpenter

📌 Architecture Overview

Workflow sequence:

Terraform

Provisions AWS infrastructure:

VPC

EKS Cluster

ECR Repository

IAM roles

Karpenter (node autoscaling)

Uses S3 backend + DynamoDB locking for remote state

Docker

Application is containerized

Image is built and tagged with git commit SHA

Image is pushed to Amazon ECR

Kubernetes

Application is deployed to EKS

Rolling update strategy

HPA (Horizontal Pod Autoscaler) enabled

🗂 Repository Structure
G:.
├───.github
│   └───workflows/ci-cd.yaml  -  # Run Automation pipeline
                 / terraform-backend.yaml  # One time S3 + Dynamodb Backend Create
                 / terraform-destroy.yaml  # When Need Terraform Destroy
├───app   # Nodejs Demo App

├───k8s
│   ├───app/manifest*
│   └───hpa/manifest*
├───terraform
│   │   └───providers 
│   │                
│   └───modules
│       ├───aws-auth
│       ├───ecr
│       ├───efk
│       ├───eks
│       ├───karpenter
│       ├───nodegroup
│       └───vpc
└───terraform-backend

⚙️ Technologies Used

Cloud: AWS

Infrastructure: Terraform

Containerization: Docker

Orchestration: Kubernetes (EKS)

Autoscaling: Karpenter + HPA

CI/CD: GitHub Actions

Registry: Amazon ECR

🚀 CI/CD Pipeline Flow
1️⃣ Terraform – Infrastructure Provisioning

Initializes Terraform with remote backend

Applies infrastructure changes

Ensures idempotent execution (no duplicate infra)

2️⃣ Build & Push Docker Image

Builds Docker image from app/

Tags image with github.sha

Pushes image to fixed ECR repository

3️⃣ Deploy to EKS

Updates kubeconfig for EKS

Ensures Kubernetes namespace exists

Injects Docker image into manifest

Applies manifests using kubectl apply

🔐 Terraform State Management

Backend: Amazon S3

Locking: DynamoDB

Prevents:

Duplicate infrastructure

Concurrent state corruption

Accidental re-creation during CI/CD runs

📦 ECR Strategy (Design Decision)

ECR repository name is fixed and known

Terraform creates the repository

CI/CD references it deterministically

Reason:

ECR repository names are application identifiers and should remain stable to avoid fragile pipeline dependencies.

🧠 Key Design Decisions

Immutable images (no latest tag)

No Terraform output dependency in Docker steps

Idempotent Kubernetes deployment

Manual destroy workflow (safe teardown)

Namespace creation handled explicitly

🧪 Deployment Verification

After deployment, verify:

kubectl get pods -n app
kubectl get svc -n app
kubectl rollout status deployment/demo-nodejs-app -n app

🧹 Infrastructure Cleanup

Terraform destroy is intentionally not automatic.

To destroy infrastructure:

Use a manual GitHub Actions workflow

Requires explicit confirmation to avoid accidental deletion

📄 Prerequisites

AWS Account

EKS-compatible IAM permissions

GitHub repository secrets:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_ACCOUNT_ID

AWS_REGION

🎯 Outcome

✔ Fully automated CI/CD pipeline
✔ Production-grade Terraform setup
✔ Scalable Kubernetes cluster
✔ Reliable deployments
