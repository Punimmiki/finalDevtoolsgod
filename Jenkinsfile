pipeline {
    agent any

    environment {
        FRONTEND_IMAGE  = 'your-frontend-image:latest'
        BACKEND_IMAGE   = 'your-backend-image:latest'
        REMOTE_HOST     = 'g64070172@34.142.247.166'
        SSH_CREDENTIALS = 'ssh-prod_instance'
    }

    stages {
        stage('Build Frontend') {
            steps {
                script {
                    // Build the Vue.js frontend
                    sh "docker build -t ${FRONTEND_IMAGE} -f frontend/Dockerfile frontend/"
                }
            }
        }

        stage('Build Backend') {
            steps {
                script {
                    // Build the Node.js backend
                    sh "docker build -t ${BACKEND_IMAGE} -f backend/Dockerfile backend/"
                }
            }
        }

        stage('Run Docker on Remote Server') {
            steps {
                sshagent([SSH_CREDENTIALS]) {
                    sh "ssh -o StrictHostKeyChecking=no $REMOTE_HOST 'docker stop \$(docker ps -a -q) || true'"
                    sh "ssh -o StrictHostKeyChecking=no $REMOTE_HOST 'docker rm \$(docker ps -a -q) || true'"
                    sh "ssh -o StrictHostKeyChecking=no $REMOTE_HOST 'docker rmi \$(docker images -q) || true'"
                    sh "ssh -o StrictHostKeyChecking=no $REMOTE_HOST 'docker run -d --name frontend -p 8080:80 ${FRONTEND_IMAGE}'"
                    sh "ssh -o StrictHostKeyChecking=no $REMOTE_HOST 'docker run -d --name backend ${BACKEND_IMAGE}'"
                    sh "ssh -o StrictHostKeyChecking=no $REMOTE_HOST 'docker ps -a'"
                }
            }
        }
    }
}
