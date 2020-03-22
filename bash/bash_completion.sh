# Docker
curl -L https://raw.githubusercontent.com/docker/docker-ce/$(docker --version | awk -F' ' '{print $3}' | cut -c 1-5)/components/cli/contrib/completion/bash/docker > $(brew --prefix)/etc/bash_completion.d/docker

# docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose > $(brew --prefix)/etc/bash_completion.d/docker-compose

# git
curl -L https://raw.githubusercontent.com/git/git/v$(git version | awk -F' ' '{print $3}')/contrib/completion/git-completion.bash > $(brew --prefix)/etc/bash_completion.d/git

# vagrant
curl -L https://raw.githubusercontent.com/hashicorp/vagrant/v$(vagrant -v | awk -F' ' '{print $2}')/contrib/bash/completion.sh > $(brew --prefix)/etc/bash_completion.d/vagrant

# kubectl
kubectl completion bash > $(brew --prefix)/etc/bash_completion.d/kubectl
kind completion bash > $(brew --prefix)/etc/bash_completion.d/kind

# terraform
echo "complete -C /usr/local/Cellar/tfenv/1.0.2/versions/0.12.20/terraform terraform" > $(brew --prefix)/etc/bash_completion.d/terraform

# ansible
curl -L https://raw.githubusercontent.com/dysosmus/ansible-completion/master/ansible-completion.bash > $(brew --prefix)/etc/bash_completion.d/ansible
curl -L https://raw.githubusercontent.com/dysosmus/ansible-completion/master/ansible-playbook-completion.bash > $(brew --prefix)/etc/bash_completion.d/ansible-playbook
curl -L https://raw.githubusercontent.com/dysosmus/ansible-completion/master/ansible-vault-completion.bash > $(brew --prefix)/etc/bash_completion.d/ansible-vault

