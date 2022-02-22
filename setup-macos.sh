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
echo "Installing Homebrew"
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update
echo "Install Homebrew Packages"
brew tap homebrew/bundle
brew bundle --file=~/brew/brewfile

echo_ok "Cleaning up..."
brew cleanup

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


echo_ok "Configuring OSX..."

# change default screenshots folder
mkdir ~/screenshots
defaults write com.apple.screencapture location /Users/your-username/screenshots

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Finish installation script
echo_ok "Installation finished, enjoy."