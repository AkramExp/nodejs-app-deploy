pipeline {
    agent any
    environment {
        ANSIBLE_SERVER = "ansible server ip"
    }
    stages {
        stage("provision deployment server") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                        SERVER_IP = sh(
                            script: "terraform output server_ip"
                            returnStdout=true
                        ).trim()    
                    }
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
                        sshCommand remote: remote, command: "ansible-playbook --inventory $SERVER_IP, --private-key ~/.ssh/id_rsa --user civo deploy-app.yaml"
                    }
                }
            }
        }
    }
}