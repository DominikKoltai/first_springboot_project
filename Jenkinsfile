pipeline {
    agent any
    
    tools {
        jdk 'jdk17'
        maven 'maven3'
    }
    
    environment {
        SCANNER_HOME=tool 'sonar-scanner'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/DominikKoltai/first_springboot_project.git'
            }
        }
        
        stage('Code Compile') {
            steps {
                sh "mvn clean compile"
            }
        }
        
        stage('Unit Tests') {
            steps {
                sh "mvn test"
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=FirstSpringbootProject \
                    -Dsonar.java.binaries=. \
                    -Dsonar.projectKey=FirstSpringbootProject '''
                }
            }
        }

        stage("OWASP Dependency Check"){
            steps{
                dependencyCheck additionalArguments: '--scan ./ ' , odcInstallation: 'DP-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }

        stage("Code/Artifact Build"){
            steps{
                sh "mvn clean install"
            }
        }

        stage("Docker Build"){
            steps {
                script {
                    withDockerRegistry(credentialsId: 'b01e7f07-d43a-46ee-a768-f6f5c14ba162', toolName: 'docker') {
                        sh "docker build -t firstspringbootproject ."
                    }
                }
            }
        }
    }
}
