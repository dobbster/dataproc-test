pipeline {
    agent any

    options {
        buildDiscarder logRotator( 
                    daysToKeepStr: '16', 
                    numToKeepStr: '10'
            )
    }

    environment {
        CREDENTIALS_ID = "broadcom-service-project2"
        BUCKET = "dataproc-artifactory"
        PATTERN = "*"
    }

    stages {
        
        stage('Cleanup Workspace') {
            steps {
                cleanWs()
                sh """
                echo "Cleaned Up Workspace For Project"
                """
            }
        }

        stage('Code Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/*']], 
                    userRemoteConfigs: [[url: 'https://github.com/dobbster/dataproc-test.git']]
                ])
            }
        }

        stage('Build JARs') {
            steps {
                sh """
                sudo jar -cvmf executablejarexample/*.mf \
                executablejarexample/myjar.jar \
                executablejarexample/*.class
                """
            }
        }

        stage('Send to GCS') {
            steps {
                sh """
                echo "Sending to bucket 'dataproc-artifactory'"
                """
                step([$class: 'ClassicUploadStep', credentialsId: env
                        .CREDENTIALS_ID,  bucket: "gs://${env.BUCKET}",
                      pattern: env.PATTERN])
                
            }
        }

        stage('Execute terraform') {
            steps {
                sh """
                echo "Executing terraform"
                """
                sudo terraform init
                sudo terraform apply

                sh """
                echo "submitting job in dataproc"
                """
            }
        }

    }   
}