pipeline {
    agent {
        kubernetes {
            yaml '''
            apiVersion: v1
            kind: Pod
            spec:
                containers:
                - name: k8s-tool
                  image: lachlanevenson/k8s-kubectl:v1.25.4
                  command: ["cat"]
                  tty: true
            '''
        }
    }

    stages {
        stage('Deploy Clean App') {
            steps {
                container('k8s-tool') {
                    sh '''
                    kubectl delete deployment simple-node-app --ignore-not-found=true
                    kubectl delete service simple-node-app-service --ignore-not-found=true
                    
                    cat <<EOF > deployment.yaml
                    apiVersion: apps/v1
                    kind: Deployment
                    metadata:
                      name: simple-node-app
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
                    
                    kubectl apply -f deployment.yaml
                    
                    kubectl expose deployment simple-node-app --name=simple-node-app-service --type=NodePort --port=3000
                    '''
                }
            }
        }
    }
}

