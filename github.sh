# helpers
function echo_ok() { echo -e '\033[1;32m'"$1"'\033[0m'; }
function echo_warn() { echo -e '\033[1;33m'"$1"'\033[0m'; }
function echo_error() { echo -e '\033[1;31mERROR: '"$1"'\033[0m'; }

# Github configuration
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