pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'deploy-docker-compose', url: 'https://github.com/zimcasts/project-zimcasts-v2.git'
            }
        }
        stage('Create Web App Resources') {
            steps {
                sh 'docker compose up -d --build'
            }
        }
        stage('Clean up') {
            steps {
                deleteDir()
            }
        }
    }
}