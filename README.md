# NodeJs App Deploy




## Description
A deployment of node js application with the **Jenkins CI/CD Pipeline** in integration with other automation tools such as **Ansible** and **Terraform**.
- Build the **Docker** image of application with Dockerfile and pushed it to DockerHub repository.
- Used the version control tool **Git** with Jenkins and wrote a Jenkinsfile automating almost everything.
- Terraform integration in Jenkinsfile to provision server on **CIVO cloud**.
- Ansible integration in Jenkinsfile to install docker on the server and deploy the application.
I tried to automate most of the things by integrating automation tools in Jenkins CI/CD Pipeline to deploy the application efficiently.

