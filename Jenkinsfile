pipeline {
   agent any
   stages {
    stage('logout') {
        steps {
            script {
                sh 'docker logout'
            }
        }
    }
    stage('login docker') {
        steps {
            script {
                sh 'docker login -u noychiffon05 -p dockerhubToken'
            }
        }
    }
    stage('Build docker') {
        steps {
            dir('ชื่อกิดเบน') {
                    sh 'docker-compose build'
                }
        }
    }
    stage('Push to docker hub') {
        steps {
            sh 'docker-compose push'
        }
    }
    stage('docker run image') {
        steps {
            dir('ชื่อกิดเบน') {
                sh "docker-compose up -d"
                
            }
        }
    }
    stage('check docker run image') {
        steps {
            dir('ชื่อกิดเบน') {
                sh "docker ps"
                
            }
        }
    }
}
}
