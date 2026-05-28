pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                bat 'npm test'
            }
        }

        stage('Load Docker Image into Minikube') {
            steps {
                bat 'minikube image load rohitbondre1309/hello-world-app:fadb3eceeaf78a42da0e3f3e3dfa943a50405ddc'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {

                bat 'kubectl apply -f k8s/deployment.yml'
                bat 'kubectl apply -f k8s/service.yml'

                bat 'kubectl rollout status deployment/hello-world-app --timeout=120s'
            }
        }

        stage('Verify Deployment') {
            steps {

                bat 'kubectl get deployments'

                bat 'kubectl get rs'

                bat 'kubectl get pods'

                bat 'kubectl get svc'
            }
        }
    }

    post {

        success {
            echo 'Deployment Successful!'
        }

        failure {
            echo 'Deployment Failed!'
        }
    }
}