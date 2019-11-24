pipeline {
    agent any
    stages {
        stage('Linting files'){
            steps {
               parallel(
                  Python: {
                      withPythonEnv('python') {
                          sh """
                                cd src/
                                pylint --load-plugins pylint_flask -j 5 block.py blockchain.py node.py transaction.py wallet.py --disable=R,C,W1202,W0603
                            """
                          }
                      }
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