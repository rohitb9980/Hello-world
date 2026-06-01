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
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_REPO:$IMAGE_TAG .'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_TOKEN'
                )]) {
                    sh 'echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push $IMAGE_REPO:$IMAGE_TAG'
            }
        }

        stage('Load Image into Minikube') {
            steps {
                sh 'minikube image load $IMAGE_REPO:$IMAGE_TAG'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yml'
                sh 'kubectl apply -f k8s/service.yml'
                sh 'kubectl set image deployment/hello-world-app hello-world-app=$IMAGE_REPO:$IMAGE_TAG'
                sh 'kubectl rollout status deployment/hello-world-app --timeout=120s'
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'kubectl get pods'
                sh 'kubectl get svc'
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
