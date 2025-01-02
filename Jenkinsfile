pipeline {
    agent any
    environment {
        DOCKER_COMPOSE_FILE = '../docker-compose.yml'
    }
    stages {
        stage('Checkout') {
            steps {
                dir ('/app/fast_api/app')
                // Git 리포지토리에서 프로젝트 가져오기
                git branch: 'main', url: 'https://github.com/sochic2/fast_api.git'
            }
        }
        stage('Build and Test') {
            steps {
                dir ('/app/fast_api')
                // Docker Compose 빌드 및 테스트 실행
                sh 'docker-compose -f $DOCKER_COMPOSE_FILE build'
                sh 'docker-compose -f $DOCKER_COMPOSE_FILE up -d'
                sh 'docker-compose -f $DOCKER_COMPOSE_FILE exec web pytest tests/'
            }
        }
        stage('Deploy') {
            steps {
                dir ('/app/fast_api')
                // 컨테이너 재시작 또는 배포
                sh 'docker-compose -f $DOCKER_COMPOSE_FILE down'
                sh 'docker-compose -f $DOCKER_COMPOSE_FILE up -d'
            }
        }
    }
    post {
        always {
            echo 'Cleaning up...'
            dir ('/app/fast_api')
            sh 'docker-compose -f $DOCKER_COMPOSE_FILE down || true'
        }
    }
}