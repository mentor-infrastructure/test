pipeline {
  agent any

  environment {
    GITHUB_OWNER = "mentor-infrastructure"
    IMAGE_NAME   = "test"
    IMAGE        = "ghcr.io/${GITHUB_OWNER}/${IMAGE_NAME}"
    IMAGE_TAG    = "${env.BUILD_NUMBER ?: 'latest'}"
    GHCR_CRED_ID = "github"
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
          docker.withTool('docker'){
            docker.withRegistry('https://ghcr.io', GHCR_CRED_ID) {
              dockerImage.push("${IMAGE_TAG}")
            }
          }
        }
      }
    }
  }

  post {
    cleanup {
      sh "docker rmi ${IMAGE}:${IMAGE_TAG} || true"
    }
    success { echo "Pushed ${IMAGE}:${IMAGE_TAG} and deployed" }
  }
}

