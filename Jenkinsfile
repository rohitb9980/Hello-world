pipeline {
    agent {
        kubernetes {
            yaml '''
            apiVersion: v1
            kind: Pod
            spec:
              containers:
              - name: helm-tool
                image: dtzar/helm-kubectl:3.12.0
                command: ["cat"]
                tty: true
            '''
        }
    }

    stages {
        stage('Clone and Deploy with Helm') {
            steps {
                container('helm-tool') {
                    sh '''
                    rm -rf Hello-world simple-node-chart
                    git clone -b task4 https://github.com/rohitb9980/Hello-world.git
                    
                    helm create simple-node-chart
                    
                    rm -rf simple-node-chart/templates/*
                    
                    cat << 'EOF' > simple-node-chart/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: simple-node-app
  labels:
    app: simple-node-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: simple-node-app
  template:
    metadata:
      labels:
        app: simple-node-app
    spec:
      initContainers:
      - name: clone-repo
        image: alpine/git:latest
        command: ["sh", "-c", "git clone -b task4 https://github.com/rohitb9980/Hello-world.git /app"]
        volumeMounts:
        - name: code
          mountPath: /app
      containers:
      - name: node-app
        image: node:20-alpine
        workingDir: /app
        command: ["sh", "-c", "rm -rf node_modules package-lock.json && npm cache clean --force && npm install && node app.js"]
        ports:
        - containerPort: 3000
        volumeMounts:
        - name: code
          mountPath: /app
      volumes:
      - name: code
        emptyDir: {}
EOF

                    cat << 'EOF' > simple-node-chart/templates/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: simple-node-app-service
spec:
  type: NodePort
  ports:
  - port: 3000
    targetPort: 3000
    nodePort: 30080
  selector:
    app: simple-node-app
EOF
                    
                    helm lint simple-node-chart
                    helm upgrade --install simple-node-app ./simple-node-chart
                    
                    helm list
                    kubectl get pods,svc -l app=simple-node-app
                    
                    echo "========================================================"
                    echo "Application deployed successfully!"
                    echo "Run this command on your host machine terminal to open the app:"
                    echo "minikube service simple-node-app-service"
                    echo "========================================================"
                    '''
                }
            }
        }
    }
}

