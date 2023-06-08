pipeline {
    agent any
    stages {
        stage("test") {
            steps {
                script {
                    def remote = [:]
                    remote.name = "ansible-server"
                    remote.host = "74.220.23.200"
                    remote.allowAnyHosts = true
                    remote.user = 'root'
                    remote.password = 'eg*W&PRlIe'
                    sshCommand remote: remote, command: 'ls'
                }
            }
        }
    }
}