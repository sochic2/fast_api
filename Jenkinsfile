pipeline {
    agent any
    environment {
        DOCKER_COMPOSE_FILE = '../docker-compose.yml'
    }
    stages {
        stage('Checkout') {
            steps {
                // Git 리포지토리에서 프로젝트 가져오기
                git branch: 'main', url: 'https://github.com/sochic2/fast_api.git'
            }
        }
        stage('Build and Test') {
            steps {
                // Docker Compose 빌드 및 테스트 실행
                echo 1111111111111111111111111111111
                sh pwd
                sh ls -al
                echo 22222222222222222222222222222222
                sh 'docker-compose -f $DOCKER_COMPOSE_FILE build'
                sh 'docker-compose -f $DOCKER_COMPOSE_FILE up -d'
                sh 'docker-compose -f $DOCKER_COMPOSE_FILE exec web pytest tests/'
            }
        }
        stage('Deploy') {
            steps {
                // 컨테이너 재시작 또는 배포
                sh 'docker-compose -f $DOCKER_COMPOSE_FILE down'
                sh 'docker-compose -f $DOCKER_COMPOSE_FILE up -d'
            }
        }
    }
    post {
        always {
            echo 'Cleaning up...'
            sh 'docker-compose -f $DOCKER_COMPOSE_FILE down || true'
        }
    }
}