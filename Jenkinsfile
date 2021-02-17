/* Pipeline */

pipeline {
  agent { label "master"}
  options { 
    disableConcurrentBuilds()
  }

  tools {
    jdk 'java-8'
    maven 'maven-3'
    }

  environment {
    NEXUS_FQDN     = 'ec2-15-206-189-141.ap-south-1.compute.amazonaws.com'
    NEXUS_PORT     = '8081'
    ARTIFACT_VERSION = '1.0.0-SNAPSHOT'
    JAVA_HOME      = "/usr/java/jdk1.8.0_191-amd64"
    MAVEN_HOME     = "/opt/maven"
  }

  stages {
    stage('build') {
      steps {
        script {
          sh "sudo docker build -t arnabdnandy1706/postgresql:training-v1 ."
      }
    }
  }

  stage('push') {
      steps {
        script {
          sh "sudo docker push arnabdnandy1706/postgresql:training-v1"
      }
    }
  }

  stage('deploy') {
      steps {
        script {
          sh "sudo docker run -d arnabdnandy1706/postgresql:training-v1"
      }
    }
  }
}

}
