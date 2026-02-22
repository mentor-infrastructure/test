pipeline {
  agent any

  environment {
    GITHUB_OWNER = "mentor-infrastructure"
    IMAGE_NAME   = "test"
    IMAGE        = "ghcr.io/${GITHUB_OWNER}/${IMAGE_NAME}"
    IMAGE_TAG    = "${env.BUILD_NUMBER ?: 'latest'}"
    GHCR_CRED_ID = "af409faf-38cf-4174-b959-aaafe29d0837"
  }

  tools {
    'org.jenkinsci.plugins.docker.commons.tools.DockerTool' 'docker'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build & Push') {
      steps {
        script {
          dockerImage = docker.build("${IMAGE}:${IMAGE_TAG}")
          docker.withRegistry('https://ghcr.io', GHCR_CRED_ID) {
            dockerImage.push("${IMAGE_TAG}")
          }
        }
      }
    }
  }

  post {
    cleanup {
      sh "docker rmi ${IMAGE}:${IMAGE_TAG} || true"
      sh "docker rmi ${IMAGE}:latest || true"
    }
    success { echo "Pushed ${IMAGE}:${IMAGE_TAG} and deployed" }
  }
}

