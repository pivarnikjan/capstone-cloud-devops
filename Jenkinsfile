pipeline {

    environment {
        image_name = "johnyjantar/capstone-cloud-devops"
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
                    sh "docker build -t ${image_name} ."
                    sh "docker push ${image_name}"
                }
            }
        }
        stage('Deploy to AWS EKS') {
            steps{
                    sh "whoami"
                    sh "env"

            }
        }
        stage('Cleaning'){
            steps{
                sh "docker rmi ${image_name}:latest"
            }
        }


    }
}