pipeline {
    agent any
    environment {
        DOCKER_COMPOSE_FILE = 'docker-compose.jenkins.yml'
    }
    stages {
        stage('Checkout') {
            steps {
                // Git 리포지토리에서 프로젝트 가져오기
                git branch: 'main', url: 'https://github.com/sochic2/fast_api.git'
            }
        }
        stage('Build') {
            steps {
                // Docker Compose 빌드 및 테스트 실행
                sh 'docker compose -f $DOCKER_COMPOSE_FILE build'
            }
        }
        stage('Test') {
            steps {
                sh 'docker compose -f $DOCKER_COMPOSE_FILE up -d'
                sh 'docker compose -f $DOCKER_COMPOSE_FILE exec -T fastapi pytest'
                sh 'docker compose -f $DOCKER_COMPOSE_FILE down'
            }
        }
        stage('Deploy') {
            steps {
                // 컨테이너 재시작 또는 배포
                sh 'docker compose -f $DOCKER_COMPOSE_FILE up -d nginx fastapi'
            }
        }
    }
    post {
        always {
            echo 'Cleaning up...'
            sh 'docker compose -f $DOCKER_COMPOSE_FILE logs'
            sh 'docker image prune -f'
        }
    }
}