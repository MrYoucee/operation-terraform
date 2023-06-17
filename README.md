# DevOps Galactic Mission: Operation Terraform
This repository serves a simple static website by 
- Setting up a Kubernetes cluster in AWS utlizing IaC (terraform)
- Building Docker image of the simple web application, and
- Deploying the microservice using Helm.

# Prerequisities
## compulsory
- Git clone this repository to your local machine.
- Ensure you have a functional AWS account to create Elastic Kubernetes Service (EKS).
- A region to create your cluster.
- Set up AWS CLI in your local machine by installing it from the official AWS CLI documentation.
- Type the command "aws configure" and a prompt comes up to enter your AWS Access Key ID, Secret Access Key, default region, and default output format. To get these values:
    - Navigate to your console, to IAM and create first group in the "User groups" and add yourself as a "User" to the group. Assign the "User groups" the permissions necessary to create EKS. 
    - For the purpose of this task, I had the "AdministratorAccess" because it is a personal account.
    - But in an organizational settings, only permissions of least privileges will be assign by the IAM Administrator to "User groups" in order to be compliant with security measures.
    - Next, go the "Users" section, click on the created user, navigate to "Security credentials" and "Create access key", choose "Command Line Interface (CLI)", type in a "Description tag value" and create the access key.
    - Copy the "Access key" and "Secret access key" and configure your AWS CLI, you can also choose the default output format as "json".  
## optional
- Create S3 bucket in the AWS for your backend terraform state files storage (Warning! It is highly recommended that you enable Bucket Versioning on the bucket to allow for state recovery in the case of accidental deletions and human error). 
- Update this name in the bucket of 'providers.tf' file. If you wish not to store this in cloud storage, delete the terraform block on 'providers.tf' file.

# Terraform (Infrastruture setup)
- Change directory into the "terraform" folder
- Update the values of your terraform.tfvars and the backend storage bucket in providers.tf as appropriate from the created prerequisities.
- Run "terraform init" to Initialize terraform, backend and the modules.
- Run "terraform validate" to successfully validate your configurations.
- Run "terraform plan" to plan your deployment and see the changes and deployments to be made.
- Run "terraform apply" to setup your configurations in AWS.
- Once the setup is ready, run "aws eks update-kubeconfig --name <cluster_name>" to export the KUBECONFIG and connect to the cluster. 

# Helm chart
- Change back to the main repository folder.
- Run "helm install <release-name> ./simple-website". Choose the release name of your choice.
- When the deployment is up, use "kubectl get all" to see your pods, deployments, services and replicasets. 
- Furthermore, run "kubectl get svc" to get your external LoadBalancer service, copy the EXTERNAL-IP and launch into your browser, your website will be up and running.

# Documenting my Mission
## Terraform script
- From the task, it was specified that the VPC will be created in a single public subnet. This simply means that means there must be a private subnet because EKS can only be created with at least two subnets in two different availability zones.
- One public and one private subnets were created. A NAT gateway, route table and connection to the public subnet was enabled too. The private subnet is allowed to join the main route table that automatically comes with your VPC.
## Dockerfile
- Stable-alpine was used as the base image in order to ensure the image size is small as against Debian.
- You can also use distroless images to ensure the image sizes were as minimal too.
- The built image was pushed to Docker Registry, which is my choice. You can as well push to GCR or AWS ECR.
## Helm Chart
- The helm chart deploys the deployment.yaml, service.yaml and serviceaccount.yaml. The hpa.yaml and ingress.yaml were not enabled but are left customizable for you incase you wish to extend your deployments to include them.
- This is a simple website that traffic is not expected on, so the replicaCount was left at 1. 
- If you are not sure of expected traffic, it is advised to enable the hpa, so that the pods will be horizontally increased when there is traffic surge to your application (This is typical of a production-grade deployment) 
- The website in this deployment case can be reached via the service of type LoadBalancer which is an external service type, but when Ingress is enabled, endeavour to change the service type to ClusterIP.
- When you have an updated Docker image in any registry, you have to update these changes in the image section of values.yaml and also the appversion of chart.yaml.
- The chart is left completely customizable so as to maintain consistency with any changes you make in the future.
