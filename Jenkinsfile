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
                    remote.user = 'root'
                    remote.password = 'eg*W&PRlIe'
                    sshCommand remote: remote, command: 'ls'
                }
            }
        }
    }
}