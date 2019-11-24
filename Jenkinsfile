pipeline {
    agent any
    stages {
        stage('Linting files'){
            steps {
               parallel(
                  Python: {
                    sh 'docker run --rm -v $(pwd)/src:/data cytopia/pylint .'
                  },
                  Dockerfile: {
                    sh 'docker run -i hadolint/hadolint < Dockerfile'
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