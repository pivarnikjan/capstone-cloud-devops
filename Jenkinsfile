pipeline {
    agent any
    stages {
        stage('Linting files'){
            steps {
               parallel(
                  Python: {
                    echo "This is branch a"
                  },
                  Dockerfile: {
                    echo "This is branch b"
                  }
               )
            }
        }
        stage('Upload to AWS'){
            steps {
                withAWS(region:'us-west-2', credentials:'aws-static') {
                    s3Upload(file:'index.html', bucket:'jenkins-pipeline-aws')
                }
            }
        }

    }
}