pipeline {
    agent any

    options {
        buildDiscarder logRotator( 
                    daysToKeepStr: '16', 
                    numToKeepStr: '10'
            )
    }

    environment {
        GOOGLE_BUCKET = "spark-codebases"
        GOOGLE_PROJECT_ID = "broadcom-service-project2"
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
                echo "Sending to bucket 'spark-codebases"
                """
            }
        }

        stage('Execute terraform') {
            steps {
                sh """
                echo "Executing terraform"
                """

                sh """
                echo "submitting job in dataproc"
                """
            }
        }

    }   
}