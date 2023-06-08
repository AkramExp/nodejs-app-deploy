pipeline {
    agent any
    environment {
        ANSIBLE_SERVER = "74.220.19.4"
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
                        sh 'scp -o StrictHostKeyChecking=no ansible/* root@74.220.19.4:/root'

                        withCredentials([sshUserPrivateKey(credentialsId: 'server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                            sh "scp ${keyfile} root@74.220.19.4:/root/id_rsa"
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
                    remote.allowAnyHost = true

                    withCredentials([sshUserPrivateKey(credentialsId: 'server-key', keyFileVariable: 'keyFile', usernameVariable: 'user')]) {
                        remote.user = user
                        remote.identityFile = keyFile
                        sshScript remote: remote, script: "prepare-server.sh"
                        sshCommand remote: remote, command: "ansible-playbook deploy-app.yaml"
                    }
                }
            }
        }
    }
}