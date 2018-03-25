node {
 	// Clean workspace before doing anything
    deleteDir()

    try {
        stage ('Clone') {
        	checkout scm
        }
        stage ('Build') {
        	sh "docker build -t sample-nodejs-app:v1.1 ."
        }
		stage ('Push-Image'){
			sh "cat /var/lib/jenkins/pass.txt | docker login --username aikram24 --password-stdin"
			sh "docker push sample-nodejs-app:v1.1 aikram24/sample-nodejs-app:v1.1"
		}
        // stage ('Tests') {
	    //     parallel 'static': {
	    //         sh "echo 'shell scripts to run static tests...'"
	    //     },
	    //     'unit': {
	    //         sh "echo 'shell scripts to run unit tests...'"
	    //     },
	    //     'integration': {
	    //         sh "echo 'shell scripts to run integration tests...'"
	    //     }
        // }
      	stage ('Deploy') {
            sh "docker pull aikram24/sample-nodejs-app"
			sh "docker run --name=nodejsdeploy -it aikram24/sample-nodejs-app::v1.1"
      	}
    } catch (err) {
        currentBuild.result = 'FAILED'
        throw err
    }
}

