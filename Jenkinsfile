pipeline {
  agent any

  environment {
    GITHUB_OWNER = "mentor-infrastructure"
    IMAGE_NAME   = "test"
    REGISTRY     = "ghcr.io"
    IMAGE        = "${REGISTRY}/${GITHUB_OWNER}/${IMAGE_NAME}"
    IMAGE_TAG    = "${env.BUILD_NUMBER ?: 'latest'}"
    GHCR_CRED_ID = "316e92cf-8ae2-4c3a-9f49-66583f097444"
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
        container('docker') {
          script {
            // sh '''
            //     /kaniko/executor \
            //       --context dir:///home/jenkins/agent/workspace/${JOB_NAME} \
            //       --dockerfile Dockerfile \
            //       --destination ${IMAGE}:${TAG} \
            //       --cache=true \
            //       --cache-dir=/kaniko/cache \
            //       --verbosity=info
            // '''
            dockerImage = docker.build("${IMAGE}:${IMAGE_TAG}")
            docker.withTool('docker'){
              docker.withRegistry('https://ghcr.io', "${GHCR_CRED_ID}") {
                dockerImage.push("${IMAGE_TAG}")
                dockerImage.push("latest")
              }
            }
          }
        }
      }
    }

    stage('Deploy') {
      steps {
        container('helm') {
          sh "helm upgrade --install ${env.IMAGE_NAME} pipeline"
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

