pipeline {
    agent any
    environment {
        ANSIBLE_SERVER = "ansible server ip"
    }
    stages {
        stage("provision deployment server") {
            steps {
                script {
                    sh "terraform init"
                    sh "terraform apply --auto-approve"
                    sh "terraform output server_ip > ansible/hosts"
                }
            }
        }
        stage("copy files to ansible server") {
            steps {
                script {
                    sshagent(['ansible-server-key']) {
                        sh 'scp -o StrictHostKeyChecking=no ansible/* root@{{env.ANSIBLE_SERVER}}:/root'

                        withCredentials([sshUserPrivateKey(credentialsId: 'server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                            sh 'scp $keyfile root@{{env.ANSIBLE_SERVER}}:/root/id_rsa'
                        }
                    }
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    echo "calling ansible playbook to configure server"
                    def remote = [:]
                    remote.name = "ansible-server"
                    remote.host = env.ANSIBLE_SERVER
                    remote.allowAnyHosts = true

                    withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'root')]) {
                        remote.user = root
                        remote.identityFile = keyfile
                        sshScript remote: remote, script: "prepare-server.sh"
                        sshCommand remote: remote, command: "ansible-playbook deploy-app.yaml"
                    }
                }
            }
        }
    }
}