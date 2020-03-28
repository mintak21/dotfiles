## Dot Files Storehouse
1. clone repository to ${HOME}

```sh
cd ~
git clone git@github.com:mintak21/dotfiles.git
```

2. setup

```sh
# Create Dotfiles Symbolic link
make deploy GIT_NAME={GIT_NAME} GIT_EMAIL={GIT_EMAIL}
# Install Packages
make init
```

3. cleanup

```sh
make clean
cd ..
rm -rf dotfiles
```
