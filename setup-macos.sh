#!/usr/bin/env bash
# 
# Initial setup script for fresh macOS
#
# Can be run multiple times so it is idempotent
#
#
# Inspiration found from:
# 
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/
# - https://github.com/hulkk/dotfiles
#
# helpers
function echo_ok() { echo -e '\033[1;32m'"$1"'\033[0m'; }
function echo_warn() { echo -e '\033[1;33m'"$1"'\033[0m'; }
function echo_error() { echo -e '\033[1;31mERROR: '"$1"'\033[0m'; }

echo_ok "Install starting. You may be asked for your password (for sudo)."

# homebrew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
if hash brew &>/dev/null; then
	echo_ok "Homebrew already installed. Getting updates..."
	brew update
	brew doctor
else
	echo_warn "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# List of packages to be installed
PACKAGES=(
	antigen
	autoconf
	awscli
	azure-cli
	ca-certificates
	ccat
	diff-so-fancy
	exa
	fd
	gdbm
	gettext
	gh
	git
	git-flow
	gnu-sed
	httpie
	ipcalc
	jq
	libevent
	libyaml
	lua
	m4
	mpdecimal
	ncurses
	neofetch
	nmap
	oniguruma
	openssl@1.1
	pcre2
	perl
	pkg-config
	pyenv
	python@3.10
	python@3.9
	readline
	reattach-to-user-namespace
	ripgrep
	ruby
	screenresolution
	six
	sqlite
	sshpass
	terraform
	testssl
	tfswitch
	thefuck
	tig
	tmux
	tree
	utf8proc
	vim
	watch
	xz
	yamllint

)

# List of casks to be installed
CASKS=(
    alt-tab
    firefox
    iterm2
    microsoft-teams
    rectangle
    swiftdefaultappsprefpane
    visual-studio-code
    the-unarchiver
)


echo_ok "Installing packages..."
brew install "${PACKAGES[@]}"

echo_ok "Cleaning up..."
brew cleanup

echo_ok "Installing cask..."
# brew install caskroom/cask/brew-cask
brew tap caskroom/cask

echo_ok "Installing casks apps..."
brew install "${CASKS@]}"

# Extensions for Visual Studio Code
echo_ok "Installing VS Code Extensions..."

VSCODE_EXTENSIONS=(
    dhoeric.ansible-vault
    eamodio.gitlens
    tomphilbin.gruvbox-themes
    hashicorp.terraform
    ms-toolsai.jupyter
    ms-toolsai.jupyter-keymap
    ms-toolsai.jupyter-renderers
    DavidAnson.vscode-markdownlint
    esbenp.prettier-vscode
    ms-python.python
    redhat.vscode-yaml
    #ms-python.vscode-pylance
)

if hash code &>/dev/null; then
	echo_ok "Installing VS Code extensions..."
	for i in "${VSCODE_EXTENSIONS[@]}"; do
		code --install-extension "$i"
	done
fi

# oh-my-zsh installation
if [[ ! -f ~/.zshrc ]]; then
	echo ''
	echo '##### Installing oh-my-zsh...'
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

	cp ~/.zshrc ~/.zshrc.orig
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
	chsh -s /bin/zsh
fi

# python installation
echo_ok "Installing Python packages..."
PYTHON_PACKAGES=(
	virtualenv
	virtualenvwrapper
)
sudo pip install "${PYTHON_PACKAGES[@]}"

## Fonts 
echo_ok "Installing fonts..."
brew tap caskroom/fonts
FONTS=(
	font-clear-sans
	font-consolas-for-powerline
	font-dejavu-sans-mono-for-powerline
	font-fira-code
	font-fira-mono-for-powerline
	font-inconsolata
	font-inconsolata-for-powerline
	font-liberation-mono-for-powerline
	font-menlo-for-powerline
	font-roboto
    	font-source-code-pro-for-powerline
)
brew cask install "${FONTS[@]}"


echo_ok "Configuring OSX..."

# change default screenshots folder
mkdir ~/screenshots
defaults write com.apple.screencapture location /Users/your-username/screenshots

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Github configuration, remove or comment out if you want to do this manually
echo_ok "Configuring Github"

if [[ ! -f ~/.ssh/id_rsa ]]; then
	echo ''
	echo '##### Please enter your github username: '
	read github_user
	echo '##### Please enter your github email address: '
	read github_email

	# setup github
	if [[ $github_user && $github_email ]]; then
		# setup config
		git config --global user.name "$github_user"
		git config --global user.email "$github_email"
		git config --global github.user "$github_user"
		# git config --global github.token your_token_here
		git config --global color.ui true
		git config --global push.default current
		# VS Code support
		git config --global core.editor "code --wait"

		# set rsa key
		curl -s -O http://github-media-downloads.s3.amazonaws.com/osx/git-credential-osxkeychain
		chmod u+x git-credential-osxkeychain
		sudo mv git-credential-osxkeychain "$(dirname $(which git))/git-credential-osxkeychain"
		git config --global credential.helper osxkeychain

		# generate ssh key
		cd ~/.ssh || exit
		ssh-keygen -t rsa -C "$github_email"
		pbcopy <~/.ssh/id_rsa.pub
		echo ''
		echo '##### The following rsa key has been copied to your clipboard: '
		cat ~/.ssh/id_rsa.pub
		echo '##### Follow step 4 to complete: https://help.github.com/articles/generating-ssh-keys'
		ssh -T git@github.com
	fi
fi

# Finish installation script
echo_ok "Installation finished, enjoy."
