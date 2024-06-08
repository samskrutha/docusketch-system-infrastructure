pipeline {
    agent any
    environment {
        AWS_CREDENTIALS_ID = 'aws-credentials'  
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: ''
            }
        }
        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CREDENTIALS_ID}"]]) {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CREDENTIALS_ID}"]]) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }
        stage('Review and Approve') {
            steps {
                script {
                    input message: 'Approve plan to apply?', ok: 'Apply'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CREDENTIALS_ID}"]]) {
                    sh 'terraform apply tfplan'
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
