# git
curl -L https://raw.githubusercontent.com/git/git/v$(git version | awk -F' ' '{print $3}')/contrib/completion/git-completion.bash >$(brew --prefix)/etc/bash_completion.d/git

# Docker
curl -L https://raw.githubusercontent.com/docker/cli/v$(docker --version | awk -F' ' '{print $3}' | awk -F',' '{print $1}')/contrib/completion/bash/docker >$(brew --prefix)/etc/bash_completion.d/docker
# docker-for-mac の持つcompletionにより補完
# ln -fnsv /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion $(brew --prefix)/etc/bash_completion.d/docker

# docker-compose
# 不要
# curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose >$(brew --prefix)/etc/bash_completion.d/docker-compose
# docker-for-mac の持つcompletionにより補完
# ln -fnsv /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-compose

# kubectl
kubectl completion bash >$(brew --prefix)/etc/bash_completion.d/kubectl
kind completion bash >$(brew --prefix)/etc/bash_completion.d/kind

# vagrant
curl -L https://raw.githubusercontent.com/hashicorp/vagrant/v$(vagrant -v | awk -F' ' '{print $2}')/contrib/bash/completion.sh >$(brew --prefix)/etc/bash_completion.d/vagrant

# ansible (disabled 2020/03)
#curl -L https://raw.githubusercontent.com/dysosmus/ansible-completion/master/ansible-completion.bash > $(brew --prefix)/etc/bash_completion.d/ansible
#curl -L https://raw.githubusercontent.com/dysosmus/ansible-completion/master/ansible-playbook-completion.bash > $(brew --prefix)/etc/bash_completion.d/ansible-playbook
#curl -L https://raw.githubusercontent.com/dysosmus/ansible-completion/master/ansible-vault-completion.bash > $(brew --prefix)/etc/bash_completion.d/ansible-vault

# aws-cli
complete -C '$(brew --prefix)/bin/aws_completer' aws

# podman
podman completion -f $(brew --prefix)/etc/bash_completion.d/podman bash
