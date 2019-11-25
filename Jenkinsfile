pipeline {

    environment {
        registry = "johnyjantar/capstone-cloud-devops"
    }
    agent any
    stages {
        stage('Linting files'){
            steps {
               parallel(
                  Python: {
                    sh """
                        cd src
                        pylint utility/hash_util.py --disable=R,C,W1202,W0603
                    """
                  },
                  Dockerfile: {
                    sh 'docker run --rm -i hadolint/hadolint < Dockerfile'
                  }
               )
            }
        }
        stage('Building image') {
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                    sh "docker build -t ${registry}:${BUILD_NUMBER} ."
                    sh "docker push ${registry}:${BUILD_NUMBER}"
                }
            }
        }
        stage('Cleaning'){
            steps{
                sh "docker rm ${registry}:${BUILD_NUMBER}"
            }
        }

        stage('Deploy to AWS EKS'){
            steps {
                withAWS(region:'us-west-2', credentials:'aws-static') {
                    s3Upload(file:'src/ui/', bucket:'jenkins-pipeline-aws')
                }
            }
        }

    }
}