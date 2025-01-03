pipeline {
    agent any
    environment {
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'
    }
    stages {
        stage('Checkout') {
            steps {
                dir('/app/fastapi') {
                    // Git 리포지토리에서 프로젝트 가져오기
                    git branch: 'main', url: 'https://github.com/sochic2/fast_api.git'
                }
            }
        }
        stage('Build') {
            steps {
                dir('/app/fastapi') {
                    // Docker Compose 빌드 및 테스트 실행
                    sh 'docker compose -f $DOCKER_COMPOSE_FILE build'
                }
            }
        }
        stage('Test') {
            steps {
                dir('/app/fastapi') {
                    sh 'docker compose -f $DOCKER_COMPOSE_FILE up -d'
                    sh 'docker compose -f $DOCKER_COMPOSE_FILE exec -T fastapi pytest'
                    sh 'docker compose -f $DOCKER_COMPOSE_FILE down'
                }
            }
        }
        stage('Deploy') {
            steps {
                dir('/app/fastapi') {
                    // 컨테이너 재시작 또는 배포
                    sh 'docker compose -f $DOCKER_COMPOSE_FILE up -d'
                }
            }
        }
    }
    post {
        always {
            dir('/app/fastapi') {
                echo 'Cleaning up...'
                sh 'docker compose -f $DOCKER_COMPOSE_FILE logs'
                sh 'docker image prune -f'
            }
        }
    }
}