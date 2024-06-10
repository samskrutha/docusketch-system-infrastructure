pipeline {
    agent any
    environment {
        AWS_CREDENTIALS_ID = 'aws-credentials'
        PATH = "${env.PATH}:/home/ubuntu/.local/bin"
    }
    stages {
        stage('Verify Terraform Installation') {
            steps {
                echo 'Verifying Terraform installation...'
                sh 'terraform -version'
            }
        }
        stage('Terraform Init') {
            steps {
                echo 'Initializing Terraform...'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CREDENTIALS_ID}"]]) {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                echo 'Running Terraform plan...'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CREDENTIALS_ID}"]]) {
                    sh 'terraform plan -var-file=terraform.tfvars -out=tfplan'
                }
            }
        }
        stage('Terraform Show') {
            steps {
                echo 'Showing Terraform plan...'
                sh 'terraform show -json tfplan > tfplan.json'
                script {
                    def tfplan = readFile('tfplan.json')
                    echo tfplan
                }
            }
        }
        stage('Checkov') {
            steps {
                script {
                    def checkovStatus = sh(script: 'checkov -d . --output-file-path checkov-report.json', returnStatus: true)
                    if (checkovStatus != 0) {
                        echo "Checkov found issues, but continuing the pipeline."
                    }
                    sh 'ls -al'
                    sh 'cat checkov-report.json || echo "checkov-report.json not found"'
                }
            }
        }
        stage('Review and Approve') {
            steps {
                echo 'Review and approve...'
                script {
                    input message: 'Approve plan to apply?', ok: 'Apply'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                echo 'Applying Terraform plan...'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CREDENTIALS_ID}"]]) {
                    sh 'terraform apply tfplan'
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning workspace...'
            cleanWs()
        }
        success {
            archiveArtifacts artifacts: 'checkov-report.json', allowEmptyArchive: true
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: '', reportFiles: 'checkov-report.json', reportName: 'Checkov Report', reportTitles: 'Checkov Report'])
        }
    }
}
