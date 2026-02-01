pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Install deps') {
      steps {
        bat '''
          if not exist .venv py -m venv .venv
          call .venv\\Scripts\\activate
          python -m pip install -U pip
          pip install -r requirements.txt
        '''
      }
    }

    stage('Run Robot + Allure') {
      steps {
        bat '''
          call .venv\\Scripts\\activate
          rmdir /S /Q results 2>nul
          rmdir /S /Q allure-results 2>nul
          robot -d results --listener allure_robotframework:allure-results tests
        '''
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: 'results/**', allowEmptyArchive: true
      archiveArtifacts artifacts: 'allure-results/**', allowEmptyArchive: true
      allure includeProperties: false, jdk: '', results: [[path: 'allure-results']]
    }
  }
}
