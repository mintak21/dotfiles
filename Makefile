GIT_EMAIL=mintak21@gmail.com

.PHONY: install deploy clean

deploy:
	sh scripts/deploy.sh ${GIT_NAME} ${GIT_EMAIL}

install: deploy
	sh scripts/install.sh
	sh scripts/bash_completion.sh

clean:
	sh scripts/unlink.sh
