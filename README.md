# macOS setup script
## Changelog
18/02/2022 - modified order and updated readme. added some explanations and list of packages  
15/02/2022 - initial commit, no testrun yet on script
***
## Briefing
This script was done for x86 Mac. Apple silicon might need some different packages.

Configure and add brews/casks and stuff which you want to install/automate with this script

Change path for `/Users/your-username/` to yours

Remove or comment out GitHub configuration wizard if you want to do this manually


## List of packages and sources (not complete currently)  
***
`antigen` - Small set of functions for managing zsh plugins. [Source link](https://github.com/zsh-users/antigen) - [Formulae](https://formulae.brew.sh/formula/antigen)  
`autoconf`- Automatic configure script builder.  [Source link](https://www.gnu.org/software/autoconf/) - [Formulae](https://formulae.brew.sh/formula/autoconf)  
`awscli` - This package provides a unified command line interface to Amazon Web Services. [Source Link](https://github.com/aws/aws-cli) - [Formulae](https://formulae.brew.sh/formula/awscli)  
`azure-cli` - Command line interface for Azure [Source link](https://github.com/Azure/azure-cli) - [Formulae](https://formulae.brew.sh/formula/azure-cli)  
`ca-certificates` - Mozilla CA certificate store [Source link](https://curl.se/docs/caextract.html) - [Formulae](https://formulae.brew.sh/formula/ca-certificates)  
`ccat` - Like cat but displays content with syntax highlighting [Source link](https://github.com/jingweno/ccat) - [Formulae](https://formulae.brew.sh/formula/ccat)  
`diff-so-fancy` - Good-lookin' diffs with diff-highlight and more [Source](https://github.com/so-fancy/diff-so-fancy) - [Formulae](https://formulae.brew.sh/formula/diff-so-fancy)  
`exa` - Modern replacement for 'ls' [Source](https://the.exa.website/) - [Formulae](https://formulae.brew.sh/formula/exa)  
`fd` - Simple, fast and user-friendly alternative to find [Source](https://github.com/sharkdp/fd) - [Formulae](https://formulae.brew.sh/formula/fd)  
`gdbm` - GNU database manager [Source](https://www.gnu.org/software/gdbm/) - [Formulae](https://formulae.brew.sh/formula/gdbm)  





***
## Running installation
`./setup-macos.sh`