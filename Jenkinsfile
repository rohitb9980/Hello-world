pipeline {
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: kubectl
    image: bitnami/kubectl:latest
    command:
    - sleep
    args:
    - 99d
'''
        }
    }

    stages {
        stage('Test') {
            steps {
                container('kubectl') {
                    sh 'echo hello'
                }
            }
        }
    }
}
