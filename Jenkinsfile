pipeline {
    agent any

    environment {
        DOCKER_REGISTRY_CREDENTIALS = 'DockerHubCred'
        DOCKER_IMAGE_NAME = 'aryanpatel111/spe_mini_project'
        LANG = 'en_US.UTF-8'

    }

    stages {
        stage('Clone Repository') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/master']],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [],
                    submoduleCfg: [],
                    userRemoteConfigs: [[url: 'https://github.com/AryanPatel111/SPE_MINI_PROJECT.git']]
                ])
            }
        }

        stage('Build') {
            steps {
                    sh 'mvn clean package'
            }
        }

        stage('Run Tests') {
            steps {
                    sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                    script {
                        docker.build("${DOCKER_IMAGE_NAME}", '.')
                    }
            }
        }

        stage('Push Docker Images') {
            steps {
                script {
                    docker.withRegistry('', 'DockerHubCred') {
                        sh "docker tag ${DOCKER_IMAGE_NAME}:latest ${DOCKER_IMAGE_NAME}:latest"
                        sh "docker push ${DOCKER_IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                script {
                    ansiblePlaybook(
                        playbook: 'deploy.yml',
                        inventory: 'inventory'
                    )
                }
            }
        }
    }
}