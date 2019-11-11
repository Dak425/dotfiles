#!/usr/bin/bash

fancy_echo() {
	printf "\n%b\n" "$1"
}

prefix_to_path() {
	export PATH="$1:$PATH"
}

install_base_packages() {
	fancy_echo "Installing base packages ..."
	sudo apt update && sudo apt install -y git libqlite3-dev sqlite3 vim tmux curl zsh nodejs neovim
}

pull_dotfiles() {
	git clone https://github.com/Dak425/dotfiles.git $HOME/.dotfiles
}

setup_zsh() {
	if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
		fancy_echo "Installng Oh-My-Zsh ..."
		sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	fi
	fancy_echo "Creating symlink for .zshrc ..."
	ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc

}

install_rbenv() {
	if [[ ! -d "$HOME/.rbenv" ]]; then
		fancy_echo "Installing rbenv ..."
		git clone https://github.com/sstephenson/rbenv.git "$HOME/.rbenv"
	fi
	if [[ ! -d "$HOME/.rbenv/plugins/rbenv-gem-rehash" ]]; then
		fancy_echo "Installing rbenv-gem-rehash plugin for rbenv ..."
		git clone https://github.com/sstephenson/rbenv-gem-rehash.git "$HOME/.rbenv/plugins/rbenv-gem-rehash"
	fi
	if [[ ! -d "$HOME/.rbenv/plugins/ruby-build" ]]; then
		fancy_echo "Installing ruby build plugin for rbenv ..."
		git clone https://github.com/sstephenson/ruby-build.git "$HOME/.rbenv/plugins/ruby-build"
	fi
	prefix_to_path "$HOME/.rbenv"
	eval $(rbenv -)
}

install_ruby_version() {
	fancy_echo "Setting up ruby version '$1' ..."
	rbenv install -s $1
	fancy_echo "Setting global ruby version to '$1' ..."
	rbenv global $1
	rbenv rehash
	fancy_echo "Installing rails and minitest for ruby version '$1' ..."
	gem install minitest rails
	rbenv rehash
}

install_go() {
	if [[ ! -d "$HOME/.bin/go/bin" ]]; then
		fancy_echo "Installing go binaries for version '$1' ..."
		wget -O golang.tar.gz "https://dl.google.com/go/go$1.linux-amd64.tar.gz"
        	tar -C $HOME/.bin -xzf golang.tar.gz
        	rm golang.tar.gz
	fi
}

run_setup() {
	install_base_packages
	pull_dotfiles
	install_oh_my_zsh
	install_rbenv	
	install_ruby_version "2.6.5"
	install_go "1.13.3"
}

run_setup
