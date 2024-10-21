pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub') // Jenkins credentials ID for Docker Hub
        DOCKERHUB_REPO = '8197495215/i18next-app'        // Your Docker Hub repository
        IMAGE_TAG = 'latest'                             // Image tag
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning the repository...'
                git branch: 'main', url: 'https://github.com/Gowrishankarc/Deploy_to_EKS.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    // Ensure Docker is accessible and build the image
                    app = docker.build("$DOCKERHUB_REPO")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo 'Logging into Docker Hub...'
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'

                    echo 'Pushing image to Docker Hub...'
                    app.push("${env.BUILD_NUMBER}")  // Push the image with the Jenkins build number as the tag
                    app.push("latest")  // Optionally push the 'latest' tag
                }
            }
        }

        stage('Trigger ManifestUpdate') {
            steps {
                script {
                    echo 'Triggering updatemanifest job...'
                    build job: 'updatemanifest', parameters: [
                        string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)
                    ]
                }
            }
        }
    }
}
