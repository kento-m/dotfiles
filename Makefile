# install Xcode

BREW = /usr/local/bin/brew
PIP = /usr/local/var/pyenv/shims/pip

ALL: FIRST

FIRST: init ricty nord-tmux

init:
	cp .zshrc ~/
	cp .tmux.conf ~/
	cp -r nvim ~/.config/
	chsh -s /bin/zsh
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
	$(BREW) install tmux
	$(BREW) install zsh-completions
	$(BREW) tap caskroom/cask
	$(BREW) cask install iterm2
	$(BREW) cask install karabiner
	$(BREW) cask install google-chrome
	$(BREW) cask install firefox 
	$(BREW) cask install intellij-idea
	$(BREW) cask install virtualbox
	$(BREW) cask install vagrant
	$(BREW) cask install vagrant-manager

ricty:
	$(BREW) install ricty --vim-powerline --powerline
	cp /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
	fc-cache -vf

nord-tmux:
	git clone https://github.com/arcticicestudio/nord-tmux ~/.tmux/themes/nord-tmux
	curl -OL https://github.com/arcticicestudio/nord-iterm2/archive/v0.2.0.zip
	unzip v0.2.0.zip
	# https://github.com/arcticicestudio/nord-iterm2を参考にセットアップ

python:
	$(BREW) install pyenv
	CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install 2.7.13
	CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install 3.6.1
	PYENV_ROOT=/usr/local/var/pyenv pyenv init
	pyenv global 3.7.2
	curl -O https://bootstrap.pypa.io/get-pip.py
	sudo python get-pip.py


powerline:
	$(PIP) install --user powerline-shell


vim:
	$(BREW) install neovim
	$(pip) install neovim
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh ./installer.sh ~/.cache/dein
	mkdir -p .vim/templates/previm/
	curl -fLo ~/.vim/templates/previm/markdown.css https://raw.githubusercontent.com/tsuyoshiwada/dotfiles/9023005bb30d4d895f69233156dd6f488d29e841/templates/previm/markdown.css


golang:
	git clone https://github.com/dataich/goenv.git ~/.goenv
	goenv install 1.9.2
	goenv global 1.9.2
	$(BREW) install dep
	mkdir -p ~/go/bin
	mkdir -p ~/go/pkg
	mkdir -p ~/go/src
	go get -u github.com/mdempsky/gocode

java:
	$(BREW) cask install java
	$(BREW) install maven

docker:
	$(BREW) install docker
	$(BREW) cask install docker
	$(BREW) install sysdig
	curl -fLo /usr/local/share/zsh/vendor-completions/_docker https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker

k8s:
	$(BREW) cask install minikube # kubectl will be installed
	source <(kubectl completion zsh)

ruby:
	$(BREW) install rbenv ruby-build
	rbenv install 2.4.1
	rbenv global 2.4.1
	sudo gem install bundler

node:
	curl -L git.io/nodebrew | perl - setup
	nodebrew install-binary latest

cfssl:
	go get -u github.com/cloudflare/cfssl/cmd/cfssl
	go get -u github.com/cloudflare/cfssl/cmd/cfssljson
