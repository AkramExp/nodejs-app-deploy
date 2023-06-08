pipeline {
    agent any
    stages {
        stage("test") {
            steps {
                script {
                    def remote = [:]
                    remote.name = "ansible-server"
                    remote.host = "74.220.22.174"
                    remote.allowAnyHosts = true
                    withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                        remote.user = user
                        remote.identityFile = keyfile
                        sshCommand remote: remote, command: 'ls'
                    }
                }
            }
        }
    }
}