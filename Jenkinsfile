pipeline {
    agent any
    stages {
        stage('Linting files'){
            steps {
               parallel(
                  Python: {
                    sh """
                        cd src/utility
                        pylint -j 3 hash_util.py printable.py verification.py --disable=R,C,W1202,W0603
                    """
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
                    s3Upload(file:'src/ui/', bucket:'jenkins-pipeline-aws')
                }
            }
        }

    }
}