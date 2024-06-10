pipeline {
    agent any
    environment {
        INFRACOST_API_KEY = credentials('infracost-api-key')  
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
        stage('Infracost') {
            steps {
                script {
                    if (!fileExists('/usr/local/bin/infracost')) {
                        sh 'curl -sSL https://github.com/infracost/infracost/releases/latest/download/infracost-linux-amd64.tar.gz | tar xz -C /usr/local/bin'
                    }
                    sh 'infracost breakdown --path . --format json --out-file infracost.json --api-key ${INFRACOST_API_KEY}'
                    sh 'infracost report --path infracost.json --format html --out-file infracost-report.html'
                }
            }
        }
        stage('Checkov') {
            steps {
                script {
                    if (!fileExists('/usr/local/bin/checkov')) {
                        sh 'pip install checkov'
                    }
                    sh 'checkov -d . --output-file-path checkov-report.json'
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
            archiveArtifacts artifacts: 'infracost-report.html, checkov-report.json', allowEmptyArchive: true
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: '', reportFiles: 'infracost-report.html', reportName: 'Infracost Report', reportTitles: 'Infracost Report'])
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: '', reportFiles: 'checkov-report.json', reportName: 'Checkov Report', reportTitles: 'Checkov Report'])
        }
    }
}
