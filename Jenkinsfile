pipeline {
    agent any
   
    environment {
        AWS_REGION = 'us-east-1'
        REGISTY_REPO = 'https://registry.hub.docker.com'
        DOCKER_IMAGE_NAME = 'leonardobenitez/test-app'
        KUBECONFIG = "/var/lib/jenkins/.kube/config" // k8s files
    }
   
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                 dockerImage = docker.build("$DOCKER_IMAGE_NAME:${env.GIT_COMMIT}")
                }
            }
        }
       

        stage('Push to REGISTY') {
            steps {
                script {
                   docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                      dockerImage.push()
                   }
                }
            }
        }

        stage('Deploy to K8s') {
            steps {
                script {
                    // Set KUBECONFIG environment variable
                    withEnv(["KUBECONFIG=${KUBECONFIG}"]) {
                        // Get the latest image tag from the GIT_COMMIT environment variable
                        def imageTag = env.GIT_COMMIT
                        
                        // Replace the placeholder ${IMAGE_TAG} in deployment.yaml with the actual image tag
                        sh "sed -i 's|\${IMAGE_TAG}|${imageTag}|' deployment.yaml"
                        
                        // Apply deployment.yaml to the K8s cluster
                        sh "kubectl apply -f deployment.yaml"
                        sh "kubectl apply -f service.yaml"
                    }
                }
            }
        }
    }
}
