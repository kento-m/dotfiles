BREW = /usr/local/bin/brew

first: init ricty nord-tmux pyenv
second: python powerline vim goenv java docker minikube rbenv nodebrew
third: golang cfssl ruby node k8s-completion

###############
#
# first
#
###############

init:
	cp .zshrc ~/
	cp .tmux.conf ~/
	cp -r nvim ~/.config/
	chsh -s /bin/zsh
	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	$(BREW) install tmux
	$(BREW) install zsh-completions
	$(BREW) tap caskroom/cask
	$(BREW) cask install iterm2
	$(BREW) cask install karabiner-elements
	$(BREW) cask install google-chrome
	$(BREW) cask install firefox 
	#$(BREW) cask install intellij-idea-ce
	$(BREW) cask install intellij-idea
	$(BREW) cask install virtualbox
	$(BREW) cask install vagrant
	$(BREW) cask install vagrant-manager

ricty:
	$(BREW) tap sanemat/font
	$(BREW) install ricty --vim-powerline --powerline
	cp /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
	fc-cache -vf

nord-tmux:
	git clone https://github.com/arcticicestudio/nord-tmux ~/.tmux/themes/nord-tmux
	curl -OL https://github.com/arcticicestudio/nord-iterm2/archive/v0.2.0.zip
	unzip v0.2.0.zip

pyenv:
	$(BREW) install pyenv

goenv:
	git clone https://github.com/dataich/goenv.git ~/.goenv

java:
	$(BREW) tap AdoptOpenJDK/openjdk
	$(BREW) cask install adoptopenjdk8
	$(BREW) install maven

docker:
	$(BREW) cask install docker
	$(BREW) install sysdig
	curl -fLo /usr/local/share/zsh/vendor-completions/_docker https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker

minikube:
	$(BREW) cask install minikube # kubectl will be installed

rbenv:
	$(BREW) install rbenv ruby-build

nodebrew:
	curl -L git.io/nodebrew | perl - setup

###############
#
# Second
#
###############

python:
	CFLAGS="-I$$(xcrun --show-sdk-path)/usr/include" pyenv install 2.7.17
	CFLAGS="-I$$(xcrun --show-sdk-path)/usr/include" pyenv install 3.8.1
	pyenv global 3.7.17 3.8.1
	curl -O https://bootstrap.pypa.io/get-pip.py
	sudo python get-pip.py

powerline:
	pip install --user powerline-shell

vim:
	$(BREW) install neovim
	pip install neovim
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh ./installer.sh ~/.cache/dein
	mkdir -p ~/.vim/templates/previm/
	curl -fLo ~/.vim/templates/previm/markdown.css https://raw.githubusercontent.com/tsuyoshiwada/dotfiles/9023005bb30d4d895f69233156dd6f488d29e841/templates/previm/markdown.css


golang:
	goenv install 1.14
	goenv global 1.14
	mkdir -p ~/go/bin
	mkdir -p ~/go/pkg
	mkdir -p ~/go/src

cfssl:
	go get -u github.com/cloudflare/cfssl/cmd/cfssl
	go get -u github.com/cloudflare/cfssl/cmd/cfssljson

ruby:
	rbenv install 2.4.1
	rbenv global 2.4.1
	sudo gem install bundler

node:
	nodebrew install-binary latest
	#npm install -g vue-cli

k8s-completion:
	source <(kubectl completion zsh)
update-dotfiles:

rust:
	curl https://sh.rustup.rs -sSf | sh
	cp ~/.rustup/toolchains/stable-x86_64-apple-darwin/share/zsh/site-functions/_cargo /usr/local/share/zsh-completions
	rustup completions zsh > /usr/local/share/zsh-completions/_rustup
