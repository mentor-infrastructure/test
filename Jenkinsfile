pipeline {
  agent any

  environment {
    NODE_ENV = 'test'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build & Push') {
      steps {
        sh '''
          docker build -t ghcr.io/mentor-infrastructure/test:${BUILD_NUMBER} .
          docker push ghcr.io/mentor-infrastructure/test:${BUILD_NUMBER}
        '''
      }
    }
  }
}

