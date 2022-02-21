# helpers
function echo_ok() { echo -e '\033[1;32m'"$1"'\033[0m'; }
function echo_warn() { echo -e '\033[1;33m'"$1"'\033[0m'; }
function echo_error() { echo -e '\033[1;31mERROR: '"$1"'\033[0m'; }

# Extensions for Visual Studio Code
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