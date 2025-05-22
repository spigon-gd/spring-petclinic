pipeline { // Pipeline A
  agent any
  environment {
    NEXUS = credentials('nexus')
    NEXUS_URL_MAIN = '127.0.0.1:8088'
    NEXUS_URL_MR = '127.0.0.1:8089'
    NAME = 'spring-petclinic'
    IMAGE = "$NAME:$GIT_COMMIT"
  }
  stages {
    stage('Prep') {
      steps {
        sh 'echo ===[Prep]==='
        withGradle {
          sh './gradlew clean'
        }
      }
    }
    stage('Checkstyle') {
      steps {
        sh 'echo ===[Checkstyle]==='
        withGradle {
          sh './gradlew check'
        }
        archiveArtifacts artifacts: '**/build/reports/checkstyle/*.html', fingerprint: true
      }
    }
    stage('Test') {
      steps {
        sh 'echo ===[Test]==='
        withGradle {
          sh './gradlew test'
        }
        archiveArtifacts artifacts: '**/build/reports/tests/**/*', fingerprint: true
      }
    }
    stage('Build') {
      steps {
        sh 'echo ===[Build]==='
        withGradle {
          sh './gradlew clean build -x test'
        }
      }
    }
    stage('Image') {
      steps {
        sh 'echo ===[Image]==='
        sh "docker build -t $NAME:$GIT_COMMIT ."
      }
    }
    stage('Deploy') {
      steps {
        sh 'echo ===[Deploy]==='
        sh "docker login -u $NEXUS_USR -p $NEXUS_PSW"
        sh "docker push $NEXUS_URL_MR/$IMAGE"
      }
    }
  }
  post {
    always {
      sh 'echo ***[Done]***'
    }
    failure {
      sh 'echo ///[Failed]///'
    }
  }
}
// pipeline { // Pipeline B
//   agent any
//   stages {
//     stage('Prep') {
//       steps {
//         sh 'echo ===[Prep]==='
//       }
//     }
//     stage('Build') {
//       steps {
//         sh 'echo ===[Build]==='
//       }
//     }
//     stage('Deploy') {
//       steps {
//         sh 'echo ===[Deploy]==='
//       }
//     }
//   }
// }
