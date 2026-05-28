pipeline {
    agent any

    environment {
        IMAGE_REPO = "rohitbondre1309/hello-world-app"
        IMAGE_TAG  = "${BUILD_NUMBER}"
        KUBECONFIG = "C:\\Users\\Rohit Bondre\\.kube\\config"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        
        stage('Start Minikube') {
            steps {
                sh 'minikube start --driver=docker'
                sh '''
                    New-Item -ItemType Directory -Force -Path "C:\\kube" | Out-Null
                    Copy-Item "$env:USERPROFILE\\.kube\\config" "C:\\kube\\config" -Force
                    Write-Host "Kubeconfig copied to C:\\kube\\config"
                '''
                sh 'kubectl config get-contexts'
                sh 'kubectl config use-context minikube'
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
                sh '''
                    docker build -t $IMAGE_REPO:$IMAGE_TAG .
                    docker tag $IMAGE_REPO:$IMAGE_TAG $IMAGE_REPO:latest
                '''
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_TOKEN'
                )]) {

                    sh '''
                        echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh '''
                    docker push $IMAGE_REPO:$IMAGE_TAG
                    docker push $IMAGE_REPO:latest
                '''
            }
        }

        stage('Load Image into Minikube') {
            steps {
                sh '''
                    minikube image load $IMAGE_REPO:$IMAGE_TAG
                    minikube image load $IMAGE_REPO:latest
                '''
            }
        }

        stage('Verify Kubernetes Context') {
            steps {
                sh '''
                    kubectl config current-context
                    kubectl cluster-info
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    kubectl apply -f k8s/deployment.yml
                    kubectl apply -f k8s/service.yml

                    kubectl set image deployment/hello-world-app \
                    hello-world-app=$IMAGE_REPO:$IMAGE_TAG

                    kubectl rollout status deployment/hello-world-app --timeout=120s
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    kubectl get deployments
                    kubectl get rs
                    kubectl get pods
                    kubectl get svc
                '''
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