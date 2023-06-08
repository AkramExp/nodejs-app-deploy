pipeline {
    agent any
    stages {
        stage("check") {
            steps {
                script {
                    def remote = [:]
                    remote.name = 'ansible-server'
                    remote.host = '74.220.20.100'
                    withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfiel', usernameVariable: 'user')]) {
                        remote.user = user
                        remote.identityFile = keyfile
                        sshCommand remote: remote, command 'ls -l'
                    }
                }
            }
        }
        // stage("provision deployment server") {
        //     steps {
        //         script {
        //             sh "terraform init"
        //             sh "terraform apply --auto-approve"
        //             sh "terraform output server_ip > ansible/hosts"
        //         }
        //     }
        // }
        // stage("copy files to ansible server") {
        //     steps {
        //         script {
        //             sshagent(['ansible-server-key']) {
        //                 sh 'scp -o StrictHostKeyChecking=no ansible/* root@74.220.17.252:/root'

        //                 withCredentials([sshUserPrivateKey(credentialsId: 'server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
        //                     sh 'scp $keyfile root@74.220.17.252:/root/id_rsa'
        //                 }
        //             }
        //         }
        //     }
        // }
        // stage("deploy") {
        //     steps {
        //         script {
        //             echo "calling ansible playbook to configure server"
        //             def remote = [:]
        //             remote.name = "ansible-server"
        //             remote.host = "74.220.17.252"
        //             remote.allowAnyHosts = true

        //             withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'root')]) {
        //                 remote.user = root
        //                 remote.identityFile = keyfile
        //                 sshCommand remote: remote, command: "ansible-playbook deploy-app.yaml"
        //             }
        //         }
        //     }
        // }
    }
}