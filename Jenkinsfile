node {
 	// Clean workspace before doing anything
    deleteDir()

    try {
        stage ('Clone') {
        	checkout scm
        }
        stage ('Build') {
        	sh "sudo docker build -t sample-nodejs-app:v1.1 ."
        }
		stage ('Push-Image'){
			sh "sudo cat /var/lib/jenkins/pass.txt | docker login --username aikram24 --password-stdin"
			sh "sudo docker push sample-nodejs-app:v1.1 aikram24/sample-nodejs-app:v1.1"
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
            sh "sudo docker pull aikram24/sample-nodejs-app"
			sh "sudo docker run --name=nodejsdeploy -it aikram24/sample-nodejs-app::v1.1"
      	}
    } catch (err) {
        currentBuild.result = 'FAILED'
        throw err
    }
}

