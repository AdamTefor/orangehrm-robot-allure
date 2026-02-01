pipeline {
  agent any
  options { timestamps() }

  environment {
    // Python installé chez toi
    PY = "C:\\Users\\USER\\AppData\\Local\\Programs\\Python\\Python310\\python.exe"

    // Ton vrai JDK (IMPORTANT: sans \\bin)
    JAVA_HOME = "C:\\Program Files\\Java\\jdk-17"
    PATH = "${env.JAVA_HOME}\\bin;${env.PATH}"

    RESULTS_DIR    = "results"
    ALLURE_RESULTS = "allure-results"
    VENV_DIR       = ".venv"
  }

  stages {

    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Check Tools') {
      steps {
        bat """
          echo === WHO AM I ===
          whoami

          echo === PYTHON ===
          if exist "%PY%" (echo OK: %PY%) else (echo NOT FOUND: %PY% & exit /b 1)
          "%PY%" --version
          "%PY%" -m pip --version

          echo === JAVA ===
          echo JAVA_HOME=%JAVA_HOME%
          if exist "%JAVA_HOME%\\bin\\java.exe" (echo OK: java.exe found) else (echo ERROR: java.exe not found & exit /b 1)
          if exist "%JAVA_HOME%\\bin\\javac.exe" (echo OK: javac.exe found) else (echo ERROR: javac.exe not found & exit /b 1)
          java -version
          javac -version
        """
      }
    }

    stage('Create venv + Install deps') {
      steps {
        bat """
          if not exist %VENV_DIR% (
            "%PY%" -m venv %VENV_DIR%
          )

          call %VENV_DIR%\\Scripts\\activate

          python -m pip install -U pip
          python -m pip install -r requirements.txt
        """
      }
    }

    stage('Run Robot Tests + Allure Results') {
      steps {
        bat """
          call %VENV_DIR%\\Scripts\\activate

          if exist %RESULTS_DIR% rmdir /S /Q %RESULTS_DIR%
          if exist %ALLURE_RESULTS% rmdir /S /Q %ALLURE_RESULTS%

          mkdir %RESULTS_DIR%
          mkdir %ALLURE_RESULTS%

          robot --outputdir %RESULTS_DIR% --listener allure_robotframework:%ALLURE_RESULTS% tests
        """
      }
    }
  }

  post {
    always {
      // Publier rapport Allure dans Jenkins
      allure([
        includeProperties: false,
        jdk: '',
        results: [[path: "${env.ALLURE_RESULTS}"]],
        reportBuildPolicy: 'ALWAYS'
      ])

      // Garder report.html / log.html + allure-results en artefacts
      archiveArtifacts artifacts: "${env.RESULTS_DIR}/**, ${env.ALLURE_RESULTS}/**",
                      fingerprint: true,
                      allowEmptyArchive: true
    }
  }
}
