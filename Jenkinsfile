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
          /kaniko/executor --context $WORKSPACE --dockerfile $WORKSPACE/Dockerfile \
            --destination ghcr.io/mentor-infrastructure/test:${BUILD_NUMBER} --cleanup
        '''
      }
    }
  }
}

