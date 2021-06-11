pipeline {
  // 设置全局环境变量
  environment {
    url = 'git@gitee.com:xiguatian/simple-java-maven-app.git'

  }
  // 全局代理是 none，表示全局上不设置任何代理，需要在每个步骤中设置代理
  agent none
  stages {
    // 拉取代码并构建
    stage('pull code and build') {
      // 此阶段的代理: docker 容器
      agent {
        docker {
        image 'maven:3-alpine'
        args '-v $HOME/.m2:/root/.m2'
        // 自定义的工作空间
        customWorkspace "/opt/"
        }
      }
      steps {
        // 拉取代码
        git(url: env.url, branch: 'master', credentialsId: 'gitlab')
        // 构建
        sh 'mvn -B clean package'
      }
    }
    // 构建镜像
    stage("build image"){
      agent {
        node {
          label 'master'
          customWorkspace "/opt/"

        }
      }
      steps {
        script {
          docker.withRegistry('http://192.168.122.100:80', 'harbor') {
            docker.build('app-java/myapp').push('v6.9')
          }
        }
      }
    }
    stage("deploy app"){
      agent {
        node {
          label 'master'
          customWorkspace "/opt/"

        }
      }
      steps {
        kubernetesDeploy(
          kubeconfigId: '16710f45-5f4c-4ddb-8bfc-c41e810be1cc',               // REQUIRED
          configs: 'myapp.yml', // REQUIRED
          enableConfigSubstitution: true,
          secretName: 'harbor-auth', 
          dockerCredentials: [[credentialsId: 'harbor', url: 'http://192.168.122.100:80']]
        )
      }
    }
  }
}