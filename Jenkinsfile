// Declarative Jenkins pipeline: Build -> Test -> Terraform (init / validate / plan / optional apply)
// Student: Aditya Ubale | PRN: 202301040111
pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    environment {
        TF_IN_AUTOMATION = 'true'
        // Offline validation mode: lets `terraform plan` run without a real AWS account.
        // For a real deployment, remove these and bind AWS credentials from the Jenkins credential store.
        TF_VAR_offline_validation = 'true'
        AWS_ACCESS_KEY_ID         = 'dummy'
        AWS_SECRET_ACCESS_KEY     = 'dummy'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo 'Student: Aditya Ubale | PRN: 202301040111'
                sh 'git log -1 --oneline'
            }
        }

        stage('Build') {
            steps {
                sh '''
                    python3 -m venv .venv
                    . .venv/bin/activate
                    pip install --quiet -r app/requirements.txt
                    python -m py_compile app/app.py
                    echo "Build OK"
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    . .venv/bin/activate
                    cd app
                    pytest -v --junitxml=../test-results.xml
                '''
            }
            post {
                always { junit 'test-results.xml' }
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform version'
                    sh 'terraform init -input=false -backend=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform fmt -check -diff'
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan -input=false -no-color -out=tfplan'
                    sh 'terraform show -no-color tfplan > plan.txt'
                }
                archiveArtifacts artifacts: 'terraform/plan.txt', fingerprint: true
            }
        }

        stage('Terraform Apply') {
            // Runs only when TF_APPLY=true AND real AWS credentials are configured.
            when { expression { return env.TF_APPLY == 'true' } }
            steps {
                input message: 'Apply the Terraform plan to AWS?'
                dir('terraform') {
                    sh 'terraform apply -input=false -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success { echo 'Pipeline finished successfully.' }
        failure { echo 'Pipeline failed - check the stage logs.' }
    }
}
