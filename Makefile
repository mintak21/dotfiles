GIT_EMAIL=mintak21@gmail.com

.PHONY: init deploy clean

init:
	sh scripts/init.sh
	sh scripts/bash_completion.sh

deploy:
	sh scripts/deploy.sh {GIT_NAME} {GIT_EMAIL}

clean:
	sh scripts/unlink.sh
