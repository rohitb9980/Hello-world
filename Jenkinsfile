pipeline {
    agent any

    environment {
        IMAGE_REPO  = "rohitbondre1309/hello-world-app"
        IMAGE_TAG   = "${BUILD_NUMBER}"
        KUBECONFIG  = "C:\\Users\\'Rohit Bondre'\\.kube\\config"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                powershell 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                powershell 'npm test'
            }
        }

        stage('Build Docker Image') {
            steps {
                powershell 'docker build -t ${env:IMAGE_REPO}:${env:IMAGE_TAG} .'
                powershell 'docker tag ${env:IMAGE_REPO}:${env:IMAGE_TAG} ${env:IMAGE_REPO}:latest'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_TOKEN'
                )]) {
                    powershell 'docker login -u ${env:DOCKER_USERNAME} -p ${env:DOCKER_TOKEN}'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                powershell 'docker push ${env:IMAGE_REPO}:${env:IMAGE_TAG}'
                powershell 'docker push ${env:IMAGE_REPO}:latest'
            }
        }

        stage('Load Image into Minikube') {
            steps {
                powershell 'minikube image load ${env:IMAGE_REPO}:${env:IMAGE_TAG}'
                powershell 'minikube image load ${env:IMAGE_REPO}:latest'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                powershell 'kubectl config use-context minikube'
                powershell 'kubectl apply -f k8s/deployment.yml --validate=false'
                powershell 'kubectl apply -f k8s/service.yml --validate=false'
                powershell 'kubectl set image deployment/hello-world-app hello-world-app=${env:IMAGE_REPO}:${env:IMAGE_TAG}'
                powershell 'kubectl rollout status deployment/hello-world-app --timeout=120s'
            }
        }

        stage('Verify Deployment') {
            steps {
                powershell 'kubectl get pods'
                powershell 'kubectl get services'
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