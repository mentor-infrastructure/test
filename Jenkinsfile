pipeline {
  agent any

  environment {
    GITHUB_OWNER = "mentor-infrastructure"
    IMAGE_NAME   = "test"
    IMAGE        = "ghcr.io/${GITHUB_OWNER}/${IMAGE_NAME}"
    IMAGE_TAG    = "${env.BUILD_NUMBER ?: 'latest'}"
    GHCR_CRED_ID = "af409faf-38cf-4174-b959-aaafe29d0837"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build & Push') {
      steps {
        dockerImage = docker.build dockerimagename
        dockerImage.push("latest")
        docker.withRegistry('https://ghcr.io', GHCR_CRED_ID) {
          dockerImage.push("${IMAGE_TAG}")
        }      }
    }
  }
}

