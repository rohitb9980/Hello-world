pipeline {
    agent any

    environment {
        IMAGE_REPO = "rohitbondre1309/hello-world-app"
        IMAGE_TAG  = "${BUILD_NUMBER}"
    }

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

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_REPO%:%IMAGE_TAG% .'
                bat 'docker tag %IMAGE_REPO%:%IMAGE_TAG% %IMAGE_REPO%:latest'
            }
        }

        stage('Login to Docker Hub') {
    steps {
        withCredentials([usernamePassword(
            credentialsId: 'dockerhub-creds',
            usernameVariable: 'DOCKER_USERNAME',
            passwordVariable: 'DOCKER_TOKEN'
        )]) {
            bat 'docker login -u %DOCKER_USERNAME% -p %DOCKER_TOKEN%'
            }
            }
        }


        stage('Push Docker Image') {
            steps {
                bat 'docker push %IMAGE_REPO%:%IMAGE_TAG%'
                bat 'docker push %IMAGE_REPO%:latest'
            }
        }

        stage('Load Image into Minikube') {
            steps {
                bat 'minikube image load %IMAGE_REPO%:%IMAGE_TAG%'
                bat 'minikube image load %IMAGE_REPO%:latest'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                bat 'kubectl apply -f k8s/deployment.yml'
                bat 'kubectl apply -f k8s/service.yml'
                bat 'kubectl set image deployment/hello-world-app hello-world-app=%IMAGE_REPO%:%IMAGE_TAG%'
                bat 'kubectl rollout status deployment/hello-world-app --timeout=120s'
            }
        }

        stage('Verify Deployment') {
            steps {
                bat 'kubectl get pods'
                bat 'kubectl get services'
            }
        }
    }
}
