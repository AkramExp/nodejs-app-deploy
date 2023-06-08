pipeline {
    agent any
    stages {
        stage("test") {
            steps {
                script {
                    def remote = [:]
                    remote.name = "ansible-server"
                    remote.host = "74.220.20.100"
                    remote.allowAnyHosts = true

                    node {
                        withCredentials([usernamePassword(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                            remote.user = user
                            remote.identityFile = keyfile

                            stage("SSH Steps Rocks!") {
                                sshCommand remote: remote, command: 'ls'
                            }
                        }
                    }
                }
            }
        }
    }
}