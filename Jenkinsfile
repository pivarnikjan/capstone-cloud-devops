pipeline {
    agent any
    stages {
        stage('Linting files'){
            steps {
               parallel(
                  Python: {
                      sh 'which python'
                      },
                  Dockerfile: {
                    sh 'docker run --rm -i hadolint/hadolint < Dockerfile'
                  }
               )
            }
        }
        stage('Upload to AWS'){
            steps {
                withAWS(region:'us-west-2', credentials:'aws-static') {
                    s3Upload(file:'src/ui/*.html', bucket:'jenkins-pipeline-aws')
                }
            }
        }

    }
}