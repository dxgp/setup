# Setup
This is a guide for me. I often forget how to do certain things and then I need to look them up on SO again.

## Erasing macOS on Apple Silicon
First, backup your shit. 

P.S.: Check the home directory for anything not backed up.

Steps:
1. Sign out of iCloud (`System Preferences->Apple Id->Sign out->Delete everything`)(Don't keep any backups)
2. Sign out of iMessage (`iMessage->Preferences->@iMessage->Sign Out`)
3. Shut down.
4. Keep the power button pressed until the startup options are loading.
5. Go into Options.
6. Enter the password for your account.
7. Go into disk utility.
8. Erase the highlighted drive (don't do the show all devices thing).
9. In the options, Click on erase volume group (not erase).
10. Wait for it to boot up again.
11. Activate the Mac.
12. Then exit to recovery utilities.
13. Click on install MacOS Big Sur (or Monterey).
14. Wait for it to install.

## Installing Brew
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

Give it whatever permissions it needs. Then, via brew, install:

1. Miniforge (`brew install --cask miniforge`)
2. VIM (`brew install vim`)
3. Wget (`brew install wget`)
4. Pandoc (`brew install pandoc`)
5. Tmux (`brew install tmux`)
6. Google Chrome (`brew install --cask google-chrome`)
7. R (`brew install --cask r`)
8. RStudio (`brew install --cask rstudio`)
9. MacTex (`brew install --cask mactex`)
10. jrnl (`brew install --cask jrnl`)
11. VLC (`brew install --cask VLC`)

## Setting up Conda
Once miniforge is intalled, run `conda init zsh` and let conda set up its shit. 

Create the `torch` environment using `conda create -n torch python=3.9`

Then activate it using `conda activate torch` and finally, run:

`conda install jupyter pandas numpy pytorch torchvision matplotlib bs4`

This should give you everything you need.

## Setting up the config files
### Vim
```bash
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'sheerun/vim-polygot'
Plugin 'wellle/tmux-complete.vim'
call vundle#end()
filetype plugin indent on
syntax on
set number
set mouse=a
set backspace=indent,eol,start
```


### Zsh
```bash
setopt prompt_subst
CONDA STUFF HERE
#helper functions
function precmd() {
	if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
  		env="$CONDA_DEFAULT_ENV"
	elif [[ -n "$VIRTUAL_ENV" ]]; then
  		env="$VIRTUAL_ENV"
	fi
}
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# set prompt
PROMPT="%F{153}\${env} %f%B%F{green}%n@%m%b%f %.%F{118}\$(parse_git_branch)%f%% "
```
### Tmux
```bash
# to set brefix key as C-a instead of C-b
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# better split commands
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

bind r source-file ~/.tmux.conf

# making moving between panes easier
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# enable mouse
set -g mouse on
```

## SSH

To setup SSH, copy the keys from your SSD to the home directory. There are two files, id_rsa and id_rsa.pub.

Add the keys to the ssh-agent using
```bash
ssh-add -K ~/.ssh/id_rsa
```

## If you want to setup SSH from scratch
```bash 
ssh-keygen
```
```bash
ssh-add ~/.ssh/id_rsa
```
Get your public key using:
`cat ~/.ssh/id_rsa.pub`

Then go to your GitHub Account and add the public key.

Then test if it's working using: `ssh -T git@github.com`.

## Some Applications
1. Magnet
2. Pages, Keynote
3. Visual Studio Code
4. Amphetamine
5. Texpad
6. MS-Teams
7. Silicon Info
8. The Unarchiver
9. PDF Expert

## A Few More Things to Do
1. Setup Google Cloud SDK
2. Setup GitHub SSH
3. Change Default Screenshots Folder


## Getting Cooler Icons
To get better icons, go to [macOS Icons](macosicons.com)

