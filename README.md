# setup
This is a guide for me. I often forget how to do certain things and then I need to look them up on SO again.

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


