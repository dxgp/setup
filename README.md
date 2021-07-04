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
First, setup vundle using `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
After hours of serching, the perfect theme is `Tomorrow-Night-Bright`. The theme is in the repo. Put it in the `~/.vim/colors` directory.

```bash
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'wellle/tmux-complete.vim'
call vundle#end()
filetype plugin indent on
syntax on
set number
set mouse=a
set backspace=indent,eol,start
set laststatus=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
colorscheme Tomorrow-Night-Bright
```


### Zsh
The theme you want is the `Argonaut` theme. Instructions are in the badass terminal section.

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
  print -Pn "\e]0;${env}\a"
}
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
# set prompt
PROMPT="%F{220}%n@%m%f %.%F{118}\$(parse_git_branch)%f%% "
```

### Tmux
After a little modification, here's the tmux conf that plays really well with `Tomorrow-Night-Bright` theme.

```bash
# to set brefix key as C-a instead of C-b
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix
set -g default-terminal "screen-256color"
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

# THEME STUFF
set -goq @themepack-status-left-area-left-format "#S"
set -goq @themepack-status-left-area-middle-format "#I"
set -goq @themepack-status-left-area-right-format "#P"
set -goq @themepack-status-right-area-left-format "#H"
set -goq @themepack-status-right-area-middle-format "%H:%M:%S"
set -goq @themepack-status-right-area-right-format "%d-%b-%y"
set -goq @themepack-window-status-current-format "#I:#W#F"
set -goq @themepack-window-status-format "#I:#W#F"

# Customizable prefixes and suffixes for @themepack-* format options
set -goq @themepack-status-left-area-left-prefix ""
set -goq @themepack-status-left-area-left-suffix ""
set -goq @themepack-status-left-area-middle-prefix ""
set -goq @themepack-status-left-area-middle-suffix ""
set -goq @themepack-status-left-area-right-prefix ""
set -goq @themepack-status-left-area-right-suffix ""
set -goq @themepack-status-right-area-left-prefix ""
set -goq @themepack-status-right-area-left-suffix ""
set -goq @themepack-status-right-area-middle-prefix ""
set -goq @themepack-status-right-area-middle-suffix ""
set -goq @themepack-status-right-area-right-prefix ""
set -goq @themepack-status-right-area-right-suffix ""
set -goq @themepack-window-status-current-prefix ""
set -goq @themepack-window-status-current-suffix ""
set -goq @themepack-window-status-prefix ""
set -goq @themepack-window-status-suffix ""

# Apply prefixes and suffixes to @themepack-* format options
set -gqF @themepack-status-left-area-left-format "#{@themepack-status-left-area-left-prefix}#{@themepack-status-left-area-left-format}#{@themepack-status-left-area-left-suffix}"
set -gqF @themepack-status-left-area-middle-format "#{@themepack-status-left-area-middle-prefix}#{@themepack-status-left-area-middle-format}#{@themepack-status-left-area-middle-suffix}"
set -gqF @themepack-status-left-area-right-format "#{@themepack-status-left-area-right-prefix}#{@themepack-status-left-area-right-format}#{@themepack-status-left-area-right-suffix}"
set -gqF @themepack-status-right-area-left-format "#{@themepack-status-right-area-left-prefix}#{@themepack-status-right-area-left-format}#{@themepack-status-right-area-left-suffix}"
set -gqF @themepack-status-right-area-middle-format "#{@themepack-status-right-area-middle-prefix}#{@themepack-status-right-area-middle-format}#{@themepack-status-right-area-middle-suffix}"
set -gqF @themepack-status-right-area-right-format "#{@themepack-status-right-area-right-prefix}#{@themepack-status-right-area-right-format}#{@themepack-status-right-area-right-suffix}"
set -gqF @themepack-window-status-current-format "#{@themepack-window-status-current-prefix}#{@themepack-window-status-current-format}#{@themepack-window-status-current-suffix}"
set -gqF @themepack-window-status-format "#{@themepack-window-status-prefix}#{@themepack-window-status-format}#{@themepack-window-status-suffix}"

# Theme options
set -goq  @theme-clock-mode-colour white
set -goq  @theme-clock-mode-style 24
set -goq  @theme-display-panes-active-colour default
set -goq  @theme-display-panes-colour default
set -goq  @theme-message-bg default
set -goq  @theme-message-command-bg default # NOT THIS
set -goq  @theme-message-command-fg default #NOT THIS
set -goq  @theme-message-fg default # NOT THIS
set -goq  @theme-mode-bg green # THIS IS WHAT SETS THE MENU COLOR!!!!
set -goq  @theme-mode-fg default
set -goq  @theme-pane-active-border-bg default
set -goq  @theme-pane-active-border-fg white
set -goq  @theme-pane-border-bg default
set -goq  @theme-pane-border-fg default
set -goq  @theme-status-bg black
set -goq  @theme-status-fg white
set -goq  @theme-status-interval 1
set -goq  @theme-status-justify centre
set -goqF @theme-status-left "#{@themepack-status-left-area-left-format} #[fg=white]» #[fg=green]#{@themepack-status-left-area-middle-format} #[fg=white]#{@themepack-status-left-area-right-format}"
set -goq  @theme-status-left-bg black
set -goq  @theme-status-left-fg white
set -goq  @theme-status-left-length 40
set -goqF @theme-status-right "#{@themepack-status-right-area-left-format} #[fg=white]« #[fg=green]#{@themepack-status-right-area-middle-format} #[fg=white]#{@themepack-status-right-area-right-format}"
set -goq  @theme-status-right-bg black
set -goq  @theme-status-right-fg white #sets osiris.local color
set -goq  @theme-status-right-length 40
set -goq  @theme-window-status-activity-bg black # NOT THIS
set -goq  @theme-window-status-activity-fg white #NOT THIS
set -goq  @theme-window-status-current-bg white #NOT THIS
set -goq  @theme-window-status-current-fg black
set -goqF @theme-window-status-current-format " #{@themepack-window-status-current-format} "
set -goqF @theme-window-status-format " #{@themepack-window-status-format} "
set -goq  @theme-window-status-separator ""

# Customizable prefixes and suffixes for @theme-* format options
set -goq @theme-status-left-prefix ""
set -goq @theme-status-left-suffix ""
set -goq @theme-status-right-prefix ""
set -goq @theme-status-right-suffix ""
set -goq @theme-window-status-current-prefix ""
set -goq @theme-window-status-current-suffix ""
set -goq @theme-window-status-prefix ""
set -goq @theme-window-status-suffix ""

# Apply prefixes and suffixes to @theme-* format options
set -gqF @theme-status-left "#{@theme-status-left-prefix}#{@theme-status-left}#{@theme-status-left-suffix}"
set -gqF @theme-status-right "#{@theme-status-right-prefix}#{@theme-status-right}#{@theme-status-right-suffix}"
set -gqF @theme-window-status-current-format "#{@theme-window-status-current-prefix}#{@theme-window-status-current-format}#{@theme-window-status-current-suffix}"
set -gqF @theme-window-status-format "#{@theme-window-status-prefix}#{@theme-window-status-format}#{@theme-window-status-suffix}"

# Apply @theme-* options to Tmux
set -gF  display-panes-active-colour "#{@theme-display-panes-active-colour}"
set -gF  display-panes-colour "#{@theme-display-panes-colour}"
set -gF  message-command-style "fg=#{@theme-message-command-fg},bg=#{@theme-message-command-bg}"
set -gF  message-style "fg=#{@theme-message-fg},bg=#{@theme-message-bg}"
set -gF  status-interval "#{@theme-status-interval}"
set -gF  status-justify "#{@theme-status-justify}"
set -gF  status-left "#{@theme-status-left}"
set -gF  status-left-length "#{@theme-status-left-length}"
set -gF  status-left-style "fg=#{@theme-status-left-fg},bg=#{@theme-status-left-bg}"
set -gF  status-right "#{@theme-status-right}"
set -gF  status-right-length "#{@theme-status-right-length}"
set -gF  status-right-style "fg=#{@theme-status-right-fg},bg=#{@theme-status-right-bg}"
set -gF  status-style "fg=#{@theme-status-fg},bg=#{@theme-status-bg}"
set -gwF clock-mode-colour "#{@theme-clock-mode-colour}"
set -gwF clock-mode-style "#{@theme-clock-mode-style}"
set -gwF mode-style "fg=#{@theme-mode-fg},bg=#{@theme-mode-bg}"
set -gwF pane-active-border-style "fg=#{@theme-pane-active-border-fg},bg=#{@theme-pane-active-border-bg}"
set -gwF pane-border-style "fg=#{@theme-pane-border-fg},bg=#{@theme-pane-border-bg}"
set -gwF window-status-activity-style "fg=#{@theme-window-status-activity-fg},bg=#{@theme-window-status-activity-bg}"
set -gwF window-status-current-format "#{@theme-window-status-current-format}"
set -gwF window-status-current-style "fg=#{@theme-window-status-current-fg},bg=#{@theme-window-status-current-bg}"
set -gwF window-status-format "#{@theme-window-status-format}"
set -gwF window-status-separator "#{@theme-window-status-separator}"
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
## Making a badass terminal
I'm a huge believer of finding your own zsh config and writing every line in it yourself. (I'm looking at you, `oh-my-zsh` users). The terminal might look cooler if you use oh-my-zsh but at the end of the day, do you want all that extra shit?

It's a personal thing, so, to each his own.
Here's the theme. It's called `Argonaut`. To set it up:

```bash
wget https://raw.githubusercontent.com/lysyi3m/macos-terminal-themes/master/themes/Argonaut.terminal
```
Then just go to your home folder and run it. It'll pop un in your terminal preferences. Just set it as default.

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

