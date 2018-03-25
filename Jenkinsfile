node {
 	// Clean workspace before doing anything
    deleteDir()

    try {
        stage ('Clone') {
        	checkout scm
        }
        stage ('Build') {
        	sh "sudo docker build -t aikram24/sample-nodejs-app:v1.1 ."
        }
		stage ('PushImage'){
			sh "sudo cat /var/lib/jenkins/pass.txt | sudo docker login --username aikram24 --password-stdin"
			sh "sudo docker push aikram24/sample-nodejs-app:v1.1"
		}
        stage ('Tests') {
	        parallel 'static': {
	            sh "echo 'shell scripts to run static tests...'"
	        },
	        'unit': {
	            sh "echo 'shell scripts to run unit tests...'"
	        },
	        'integration': {
	            sh "echo 'shell scripts to run integration tests...'"
	        }
        }
      	stage ('Deploy') {
            sh "sudo docker pull aikram24/sample-nodejs-app:v1.1"
			sh "sudo docker run --name nodejsdeploy -itd aikram24/sample-nodejs-app:v1.1"
			// sh "sudo docker container rm nodejsdeploy --force"
      	}
    } catch (err) {
        currentBuild.result = 'FAILED'
        throw err
    }
}

