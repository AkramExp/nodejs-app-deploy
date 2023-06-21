# NodeJs App Deploy




## Description
A DevOps Project deploying a nodejs application with the **Jenkins CI/CD Pipeline** in integration with other automation tools such as **Ansible** and **Terraform**.

Terraform is a tool to automate the infrastructer provisioning by writing Terraform files and spinning up servers in few seconds without doing the repetetive task of provisioning servers manually.

Ansible is used automate the process of making servers ready for deployment and then deploy the application on it by writing ansible playbooks which makes the deployment process efficient and to deploy the application with same configuration on any number of servers in few seconds.
- Build the **Docker** image of application with Dockerfile and pushed it to DockerHub repository.
- Used the version control tool **Git** with Jenkins and wrote a Jenkinsfile automating almost everything.
- Terraform integration in Jenkinsfile to provision server on **CIVO cloud**.
- Ansible integration in Jenkinsfile to install docker on the server and deploy the application.
I tried to automate most of the things by integrating automation tools in Jenkins CI/CD Pipeline to deploy the application efficiently.

