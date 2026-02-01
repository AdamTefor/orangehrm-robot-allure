pipeline {
  agent any

  options {
    timestamps()
  }

  environment {
    // Dossiers de sortie
    RESULTS_DIR       = "results"
    ALLURE_RESULTS    = "allure-results"
    ALLURE_REPORT_DIR = "allure-report"
    // Chemin venv
    VENV_DIR          = ".venv"
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Check Tools') {
      steps {
        bat '''
          echo === WHO AM I ===
          whoami
          echo === WHERE PYTHON ===
          where python
          python --version
          python -m pip --version
        '''
      }
    }

    stage('Create venv + Install deps') {
      steps {
        bat '''
          if not exist %VENV_DIR% (
            python -m venv %VENV_DIR%
          )

          call %VENV_DIR%\\Scripts\\activate

          python -m pip install -U pip
          python -m pip install -r requirements.txt

          echo === INSTALLED PACKAGES (short) ===
          python -m pip show robotframework
          python -m pip show robotframework-seleniumlibrary
          python -m pip show allure-robotframework
        '''
      }
    }

    stage('Run Robot Tests') {
      steps {
        bat '''
          call %VENV_DIR%\\Scripts\\activate

          if exist %RESULTS_DIR% rmdir /S /Q %RESULTS_DIR%
          if exist %ALLURE_RESULTS% rmdir /S /Q %ALLURE_RESULTS%
          mkdir %RESULTS_DIR%
          mkdir %ALLURE_RESULTS%

          REM Lance tous les tests dans ./tests
          REM --outputdir : reports Robot (log.html, report.html, output.xml)
          REM --listener allure_robotframework : genere les fichiers Allure
          robot --outputdir %RESULTS_DIR% --listener allure_robotframework:%ALLURE_RESULTS% tests
        '''
      }
    }
  }

  post {
    always {
      // Publier l’Allure Report (plugin Jenkins Allure requis)
      allure([
        includeProperties: false,
        jdk: '',
        results: [[path: "${env.ALLURE_RESULTS}"]],
        reportBuildPolicy: 'ALWAYS'
      ])

      // Archiver les rapports Robot + Allure results (utile même si build fail)
      archiveArtifacts artifacts: "${env.RESULTS_DIR}/**, ${env.ALLURE_RESULTS}/**", fingerprint: true, allowEmptyArchive: true

      // Garder les logs sur Jenkins en cas d’échec
      junit testResults: '**/output.xml', allowEmptyResults: true
    }
  }
}
