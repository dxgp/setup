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

All the conf files are in the repo. That's for when you're feeling lazy.
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
Then just go to your home folder and run it. It'll pop in in your terminal preferences. Just set it as default.

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

'''
#!/usr/bin/env python3
# Standalone C Function Dependency Extractor
# Requires: pip install clang

import sys
import os
import re
import glob
from clang.cindex import Index, CursorKind, TranslationUnit, Config

class FunctionExtractor:
    def __init__(self, project_root):
        """Initialize the extractor with project root path."""
        self.index = Index.create()
        self.project_root = os.path.abspath(project_root)
        self.target_cursor = None
        self.dependencies = set()
        self.struct_decls = {}
        self.enum_decls = {}
        self.typedef_decls = {}
        self.function_decls = {}
        self.function_defs = {}
        self.macro_defs = {}
        self.header_files = set()
        self.visited_functions = set()
        self.visited_files = set()
        
        # Try to find libclang path if not in standard location
        try:
            if not hasattr(Config, 'loaded') or not Config.loaded:
                # Common locations
                potential_paths = [
                    '/usr/lib/llvm-*/lib/libclang.so',  # Debian/Ubuntu
                    '/usr/local/opt/llvm/lib/libclang.dylib',  # macOS Homebrew
                    'C:/Program Files/LLVM/bin/libclang.dll',  # Windows
                ]
                
                for path_pattern in potential_paths:
                    paths = glob.glob(path_pattern)
                    if paths:
                        Config.set_library_file(paths[0])
                        break
        except Exception as e:
            print(f"Warning: Could not locate libclang: {e}")
            print("If you encounter errors, set the LIBCLANG_PATH environment variable.")
        
        # Setup include paths based on project structure
        self.include_paths = self._determine_include_paths()
    
    def _determine_include_paths(self):
        """Determine include paths based on project structure."""
        include_paths = []
        
        # Add common project directories as include paths
        for dir_name in ['api', 'b', 'c', 'd', 'e', 
                         'f', 'g', 'h', 'i', 'j', 'k']:
            full_path = os.path.join(self.project_root, dir_name)
            if os.path.isdir(full_path):
                include_paths.append(full_path)
                
                # Check for include subdirectory
                inc_path = os.path.join(full_path, 'include')
                if os.path.isdir(inc_path):
                    include_paths.append(inc_path)
        
        # Add standard system include paths
        include_paths.extend([
            '/usr/include',
            '/usr/local/include'
        ])
        
        return include_paths
    
    def find_includes_in_file(self, file_path):
        """Extract #include statements from a file."""
        includes = []
        try:
            with open(file_path, 'r') as f:
                for line in f:
                    match = re.match(r'#include\s+["<](.*)[">]', line.strip())
                    if match:
                        includes.append(match.group(1))
        except Exception as e:
            print(f"Warning: Could not read includes from {file_path}: {e}")
        return includes
    
    def resolve_include_path(self, include_name, from_file):
        """Try to resolve an include file path."""
        # Check in the same directory as the source file first
        if from_file:
            source_dir = os.path.dirname(from_file)
            full_path = os.path.join(source_dir, include_name)
            if os.path.exists(full_path):
                return full_path
                
        # Check in all include paths
        for inc_path in self.include_paths:
            full_path = os.path.join(inc_path, include_name)
            if os.path.exists(full_path):
                return full_path
                
        # As a fallback, search the entire project
        for root, _, files in os.walk(self.project_root):
            if include_name in files:
                return os.path.join(root, include_name)
                
        return None
    
    def get_compile_args(self):
        """Get standard compilation arguments."""
        args = ['-xc', '-std=c99']
        
        # Add include paths
        for path in self.include_paths:
            args.append(f'-I{path}')
            
        return args
    
    def parse_file(self, file_path):
        """Parse a source file with clang."""
        if not os.path.exists(file_path):
            print(f"Warning: File {file_path} does not exist, skipping")
            return None
            
        file_path = os.path.abspath(file_path)
        
        if file_path in self.visited_files:
            return None
            
        self.visited_files.add(file_path)
            
        # Get compilation arguments
        extra_args = self.get_compile_args()
        
        try:
            # Try to parse the file
            tu = self.index.parse(file_path, args=extra_args)
            if tu is None:
                print(f"Error: Could not parse {file_path}")
                return None
                
            # Check for parsing errors
            has_errors = False
            for diag in tu.diagnostics:
                if diag.severity >= 3:  # Error or fatal
                    print(f"Warning: {diag.spelling} in {file_path}:{diag.location.line}")
                    has_errors = True
                    
            if has_errors:
                print(f"Warning: {file_path} had parse errors, results may be incomplete")
                    
            return tu
        except Exception as e:
            print(f"Error parsing {file_path}: {e}")
            return None
    
    def find_function_in_tu(self, tu, target_function):
        """Find a function declaration/definition in a translation unit."""
        if not tu:
            return False
            
        def visit_node(cursor):
            if cursor.kind == CursorKind.FUNCTION_DECL and cursor.spelling == target_function:
                if cursor.is_definition():
                    self.target_cursor = cursor
                    return True
                elif not self.target_cursor:  # Keep declaration as backup
                    self.target_cursor = cursor
            
            for child in cursor.get_children():
                if visit_node(child):
                    return True
            return False
        
        visit_node(tu.cursor)
        return self.target_cursor is not None
    
    def find_function_in_files(self, files, target_function):
        """Look for the target function across multiple files."""
        for file_path in files:
            if not os.path.exists(file_path):
                continue
                
            if not file_path.endswith(('.c', '.h', '.cpp', '.hpp')):
                continue
                
            print(f"Searching for {target_function} in {file_path}")
            tu = self.parse_file(file_path)
            if tu and self.find_function_in_tu(tu, target_function):
                print(f"Found {target_function} in {file_path}")
                # If we found a definition, we're done
                if self.target_cursor.is_definition():
                    return file_path
        
        # If we only found a declaration, still return the file
        if self.target_cursor:
            return self.target_cursor.location.file.name
            
        return None
    
    def extract_code_range(self, file_path, start_line, end_line):
        """Extract a range of lines from a file."""
        try:
            with open(file_path, 'r') as f:
                lines = f.readlines()
                # Lines are 1-indexed in Clang
                return ''.join(lines[start_line-1:end_line])
        except Exception as e:
            print(f"Error extracting code: {e}")
            return ""
    
    def process_includes_in_file(self, file_path):
        """Process all includes in a file recursively."""
        includes = self.find_includes_in_file(file_path)
        
        for include in includes:
            resolved_path = self.resolve_include_path(include, file_path)
            if resolved_path and resolved_path not in self.visited_files:
                self.header_files.add(include)
                tu = self.parse_file(resolved_path)
                
                # Extract macros, typedefs, structs, etc. from the header
                if tu:
                    self._extract_declarations_from_tu(tu)
    
    def _extract_declarations_from_tu(self, tu):
        """Extract all relevant declarations from a translation unit."""
        def visit_node(cursor):
            if cursor.location.file:
                file_name = cursor.location.file.name
                
                # Track macro definitions
                if cursor.kind == CursorKind.MACRO_DEFINITION:
                    if cursor.spelling not in self.macro_defs:
                        start = cursor.extent.start.line
                        end = cursor.extent.end.line
                        code = self.extract_code_range(file_name, start, end)
                        self.macro_defs[cursor.spelling] = code
                
                # Track struct/union definitions
                elif cursor.kind in (CursorKind.STRUCT_DECL, CursorKind.UNION_DECL) and cursor.spelling:
                    key = f"{cursor.kind}_{cursor.spelling}"
                    if key not in self.struct_decls:
                        start = cursor.extent.start.line
                        end = cursor.extent.end.line
                        code = self.extract_code_range(file_name, start, end)
                        self.struct_decls[key] = code
                        
                # Track enum definitions
                elif cursor.kind == CursorKind.ENUM_DECL and cursor.spelling:
                    key = f"ENUM_{cursor.spelling}"
                    if key not in self.enum_decls:
                        start = cursor.extent.start.line
                        end = cursor.extent.end.line
                        code = self.extract_code_range(file_name, start, end)
                        self.enum_decls[key] = code
                        
                # Track typedef declarations
                elif cursor.kind == CursorKind.TYPEDEF_DECL:
                    key = f"TYPEDEF_{cursor.spelling}"
                    if key not in self.typedef_decls:
                        start = cursor.extent.start.line
                        end = cursor.extent.end.line
                        code = self.extract_code_range(file_name, start, end)
                        self.typedef_decls[key] = code
                        
                # Track functions
                elif cursor.kind == CursorKind.FUNCTION_DECL:
                    if cursor.is_definition():
                        if cursor.spelling not in self.function_defs:
                            start = cursor.extent.start.line
                            end = cursor.extent.end.line
                            code = self.extract_code_range(file_name, start, end)
                            self.function_defs[cursor.spelling] = code
                    else:
                        if cursor.spelling not in self.function_decls and cursor.spelling not in self.function_defs:
                            start = cursor.extent.start.line
                            end = cursor.extent.end.line
                            code = self.extract_code_range(file_name, start, end)
                            self.function_decls[cursor.spelling] = code
                            
            # Process children
            for child in cursor.get_children():
                visit_node(child)
                
        visit_node(tu.cursor)
    
    def collect_dependencies(self, start_cursor):
        """Recursively collect all dependencies of a function."""
        if not start_cursor:
            return
            
        self.visited_functions.add(start_cursor.spelling)
        
        # Queue of functions to process
        queue = [start_cursor]
        processed = set()
        
        while queue:
            cursor = queue.pop(0)
            if cursor.hash in processed:
                continue
                
            processed.add(cursor.hash)
            file_name = cursor.location.file.name if cursor.location.file else None
            
            # Process includes in this file
            if file_name:
                self.process_includes_in_file(file_name)
            
            def visit_node(node):
                # Track referenced functions
                if node.kind == CursorKind.CALL_EXPR:
                    called = node.referenced
                    if called and called.spelling and called.kind == CursorKind.FUNCTION_DECL:
                        self.dependencies.add(called.spelling)
                        if called.spelling not in self.visited_functions and called.spelling != cursor.spelling:
                            if called.is_definition():
                                queue.append(called)
                                self.visited_functions.add(called.spelling)
                                
                                # Store function definition
                                if called.location.file:
                                    if called.spelling not in self.function_defs:
                                        start = called.extent.start.line
                                        end = called.extent.end.line
                                        code = self.extract_code_range(called.location.file.name, start, end)
                                        self.function_defs[called.spelling] = code
                            else:
                                # Store function declaration
                                if called.location.file:
                                    if called.spelling not in self.function_decls:
                                        start = called.extent.start.line
                                        end = called.extent.end.line
                                        code = self.extract_code_range(called.location.file.name, start, end)
                                        self.function_decls[called.spelling] = code
                                        
                                        # Try to find the definition in source files
                                        self._find_function_definition(called.spelling)
                
                # Track struct/union references
                elif node.kind in (CursorKind.STRUCT_DECL, CursorKind.UNION_DECL) and node.spelling:
                    key = f"{node.kind}_{node.spelling}"
                    if key not in self.struct_decls and node.location.file:
                        start = node.extent.start.line
                        end = node.extent.end.line
                        code = self.extract_code_range(node.location.file.name, start, end)
                        self.struct_decls[key] = code
                        
                        # Also collect nested typedefs, structs, etc.
                        for child in node.get_children():
                            visit_node(child)
                
                # Track enum references
                elif node.kind == CursorKind.ENUM_DECL and node.spelling:
                    key = f"ENUM_{node.spelling}"
                    if key not in self.enum_decls and node.location.file:
                        start = node.extent.start.line
                        end = node.extent.end.line
                        code = self.extract_code_range(node.location.file.name, start, end)
                        self.enum_decls[key] = code
                
                # Track variable types
                elif node.kind == CursorKind.VAR_DECL:
                    type_node = node.type.get_declaration()
                    if type_node:
                        visit_node(type_node)
                
                # Track typedef references
                elif node.kind == CursorKind.TYPEDEF_DECL:
                    key = f"TYPEDEF_{node.spelling}"
                    if key not in self.typedef_decls and node.location.file:
                        start = node.extent.start.line
                        end = node.extent.end.line
                        code = self.extract_code_range(node.location.file.name, start, end)
                        self.typedef_decls[key] = code
                        
                        # Also collect underlying type info
                        for child in node.get_children():
                            visit_node(child)
                
                # Track included headers
                elif node.kind == CursorKind.INCLUSION_DIRECTIVE:
                    if node.location.file and node.location.file.name == file_name:
                        included_file = node.included_file
                        if included_file:
                            include_name = os.path.basename(included_file.name)
                            self.header_files.add(include_name)
                
                # Process all children
                for child in node.get_children():
                    visit_node(child)
            
            # Start recursive collection
            visit_node(cursor)
    
    def _find_function_definition(self, function_name):
        """Try to find the definition of a function in the codebase."""
        if function_name in self.function_defs:
            return  # Already have the definition
        
        print(f"Looking for definition of {function_name}...")
        
        # Get all C source files in the project
        c_files = []
        for root, _, files in os.walk(self.project_root):
            for file in files:
                if file.endswith('.c'):
                    c_files.append(os.path.join(root, file))
        
        # Search for the function definition
        for file_path in c_files:
            tu = self.parse_file(file_path)
            if not tu:
                continue
                
            # Look for the function definition
            def find_func(cursor):
                if cursor.kind == CursorKind.FUNCTION_DECL and cursor.spelling == function_name:
                    if cursor.is_definition():
                        start = cursor.extent.start.line
                        end = cursor.extent.end.line
                        code = self.extract_code_range(cursor.location.file.name, start, end)
                        self.function_defs[function_name] = code
                        print(f"Found definition for {function_name} in {file_path}")
                        return True
                        
                for child in cursor.get_children():
                    if find_func(child):
                        return True
                return False
                
            if find_func(tu.cursor):
                return  # Found it!
    
    def generate_minimal_file(self, target_function):
        """Generate a minimal file with all dependencies for the target function."""
        if not self.target_cursor:
            print(f"Error: Function {target_function} not found.")
            return None
        
        # Collect all dependencies
        self.collect_dependencies(self.target_cursor)
        
        # Start building output
        output = []
        
        # Add standard headers
        output.append("/* Generated minimal test case for function: {} */".format(target_function))
        output.append("#include <stdio.h>")
        output.append("#include <stdlib.h>")
        output.append("#include <string.h>")  # Often needed
        output.append("#include <time.h>")    # For timing
        output.append("")
        
        # Add project headers
        if self.header_files:
            output.append("/* Required headers - you may need to adjust paths */")
            for header in sorted(self.header_files):
                output.append(f"#include \"{header}\"")
            output.append("")
        
        # Add macro definitions
        if self.macro_defs:
            output.append("/* Required macro definitions */")
            for macro_code in self.macro_defs.values():
                if macro_code and len(macro_code.strip()) > 0:
                    output.append(macro_code)
            output.append("")
        
        # Add typedefs
        if self.typedef_decls:
            output.append("/* Required typedefs */")
            for typedef_code in self.typedef_decls.values():
                if typedef_code and len(typedef_code.strip()) > 0:
                    output.append(typedef_code)
            output.append("")
        
        # Add struct/union definitions
        if self.struct_decls:
            output.append("/* Required struct/union definitions */")
            for struct_code in self.struct_decls.values():
                if struct_code and len(struct_code.strip()) > 0:
                    output.append(struct_code)
            output.append("")
        
        # Add enum definitions
        if self.enum_decls:
            output.append("/* Required enum definitions */")
            for enum_code in self.enum_decls.values():
                if enum_code and len(enum_code.strip()) > 0:
                    output.append(enum_code)
            output.append("")
        
        # Add function declarations for dependencies
        if self.function_decls:
            output.append("/* Function declarations */")
            for func_name, decl in self.function_decls.items():
                if func_name in self.function_defs:
                    # Skip declarations for functions we have definitions for
                    continue
                if decl and len(decl.strip()) > 0:
                    output.append(decl)
            output.append("")
        
        # Add function definitions (excluding the target)
        if self.function_defs:
            output.append("/* Required function implementations */")
            for func_name, def_code in self.function_defs.items():
                if func_name != target_function and def_code and len(def_code.strip()) > 0:
                    output.append(def_code)
                    output.append("")
        
        # Add the target function implementation
        output.append("/* Target function */")
        if self.target_cursor.is_definition():
            start = self.target_cursor.extent.start.line
            end = self.target_cursor.extent.end.line
            target_code = self.extract_code_range(self.target_cursor.location.file.name, start, end)
            output.append(target_code)
        else:
            # If we only have a declaration, add a stub implementation
            output.append(f"/* WARNING: Only found declaration for {target_function}, implementation needs to be added */")
            if target_function in self.function_decls:
                output.append(self.function_decls[target_function])
                output.append("{")
                output.append("    /* TODO: Add implementation */")
                output.append("}")
        output.append("")
        
        # Add a test harness
        output.append("/* Test harness */")
        output.append("int main() {")
        output.append("    /* TODO: Initialize any required data structures */")
        output.append("    ")
        output.append("    /* Performance measurement */")
        output.append("    clock_t start = clock();")
        output.append("    ")
        output.append("    /* Run the function many times for benchmarking */")
        output.append("    for (int i = 0; i < 1000000; i++) {")
        output.append(f"        {target_function}(/* TODO: Add appropriate parameters */);")
        output.append("    }")
        output.append("    ")
        output.append("    clock_t end = clock();")
        output.append("    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;")
        output.append("    printf(\"Time spent: %f seconds\\n\", time_spent);")
        output.append("    ")
        output.append("    return 0;")
        output.append("}")
        
        return '\n'.join(output)

def find_c_files(directory, recursive=True):
    """Find all C source files in a directory."""
    c_files = []
    
    if recursive:
        for root, _, files in os.walk(directory):
            for file in files:
                if file.endswith(('.c', '.h')):
                    c_files.append(os.path.join(root, file))
    else:
        for file in os.listdir(directory):
            if file.endswith(('.c', '.h')):
                c_files.append(os.path.join(directory, file))
    
    return c_files

def main():
    if len(sys.argv) < 3:
        print("Usage: python extract_function.py project_root function_name [--output output_file]")
        print("Options:")
        print("  --output output_file    Specify output file (default: function_name_minimal.c)")
        print("  --no-recursive          Don't search subdirectories")
        return 1
    
    project_root = sys.argv[1]
    target_function = sys.argv[2]
    
    # Parse options
    output_file = f"{target_function}_minimal.c"
    recursive = True
    
    if "--output" in sys.argv:
        idx = sys.argv.index("--output")
        if idx + 1 < len(sys.argv):
            output_file = sys.argv[idx + 1]
    
    if "--no-recursive" in sys.argv:
        recursive = False
    
    # Initialize extractor
    extractor = FunctionExtractor(project_root)
    
    # Find source files
    files = find_c_files(project_root, recursive)
    print(f"Found {len(files)} source files in {project_root}")
    
    # Find the target function
    source_file = extractor.find_function_in_files(files, target_function)
    
    if not source_file:
        print(f"Error: Could not find function '{target_function}' in any source file.")
        return 1
    
    # Generate minimal file
    print(f"Generating minimal file for function '{target_function}'...")
    minimal_code = extractor.generate_minimal_file(target_function)
    
    if minimal_code:
        with open(output_file, 'w') as f:
            f.write(minimal_code)
        print(f"Successfully extracted minimal version to {output_file}")
        print("Note: You may need to manually adjust function prototypes and test data.")
    else:
        print("Error: Failed to generate minimal file.")
        return 1
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
'''

'''
#!/usr/bin/env python3
# Precise C Function Dependency Extractor
# Requires: pip install clang

import sys
import os
import re
import glob
from collections import deque
from clang.cindex import Index, CursorKind, TypeKind, TranslationUnit, Config

class PreciseExtractor:
    def __init__(self, project_root):
        """Initialize the extractor with project root path."""
        self.index = Index.create()
        self.project_root = os.path.abspath(project_root)
        
        # Storage for the target function and its dependencies
        self.target_cursor = None
        self.target_file = None
        
        # Track dependencies
        self.used_functions = set()  # Function names that are called
        self.used_function_cursors = {}  # Map of function name to cursor
        self.used_types = set()  # Type names that are referenced
        self.used_struct_fields = {}  # Fields used within each struct
        self.used_enums = set()  # Enum names that are referenced
        self.used_typedefs = set()  # Typedef names that are referenced
        self.used_macros = set()  # Macro names that are referenced
        
        # Track collected code
        self.struct_decls = {}
        self.enum_decls = {}
        self.typedef_decls = {}
        self.function_decls = {}
        self.function_defs = {}
        self.macro_defs = {}
        self.header_files = set()
        
        # Track visited nodes to avoid cycles
        self.visited_functions = set()
        self.visited_files = set()
        
        # Try to find libclang path if not in standard location
        try:
            if not hasattr(Config, 'loaded') or not Config.loaded:
                potential_paths = [
                    '/usr/lib/llvm-*/lib/libclang.so',  # Debian/Ubuntu
                    '/usr/local/opt/llvm/lib/libclang.dylib',  # macOS Homebrew
                    'C:/Program Files/LLVM/bin/libclang.dll',  # Windows
                ]
                
                for path_pattern in potential_paths:
                    paths = glob.glob(path_pattern)
                    if paths:
                        Config.set_library_file(paths[0])
                        break
        except Exception as e:
            print(f"Warning: Could not locate libclang: {e}")
            print("If you encounter errors, set the LIBCLANG_PATH environment variable.")
        
        # Setup include paths based on project structure
        self.include_paths = self._determine_include_paths()
    
    def _determine_include_paths(self):
        """Determine include paths based on project structure."""
        include_paths = []
        
        # Add common project directories as include paths
        for dir_name in []:
            full_path = os.path.join(self.project_root, dir_name)
            if os.path.isdir(full_path):
                include_paths.append(full_path)
                
                # Check for include subdirectory
                inc_path = os.path.join(full_path, 'include')
                if os.path.isdir(inc_path):
                    include_paths.append(inc_path)
        
        # Add standard system include paths
        include_paths.extend([
            '/usr/include',
            '/usr/local/include'
        ])
        
        return include_paths
    
    def get_compile_args(self):
        """Get standard compilation arguments."""
        args = ['-xc', '-std=c99']
        
        # Add include paths
        for path in self.include_paths:
            args.append(f'-I{path}')
            
        return args
    
    def parse_file(self, file_path):
        """Parse a source file with clang."""
        if not os.path.exists(file_path):
            print(f"Warning: File {file_path} does not exist, skipping")
            return None
            
        file_path = os.path.abspath(file_path)
        
        if file_path in self.visited_files:
            return None
            
        self.visited_files.add(file_path)
            
        # Get compilation arguments
        extra_args = self.get_compile_args()
        
        try:
            # Try to parse the file
            tu = self.index.parse(file_path, args=extra_args)
            if tu is None:
                print(f"Error: Could not parse {file_path}")
                return None
                
            # Check for parsing errors
            has_errors = False
            for diag in tu.diagnostics:
                if diag.severity >= 3:  # Error or fatal
                    print(f"Warning: {diag.spelling} in {file_path}:{diag.location.line}")
                    has_errors = True
                    
            if has_errors:
                print(f"Warning: {file_path} had parse errors, results may be incomplete")
                    
            return tu
        except Exception as e:
            print(f"Error parsing {file_path}: {e}")
            return None
    
    def find_function_in_tu(self, tu, target_function):
        """Find a function declaration/definition in a translation unit."""
        if not tu:
            return False
            
        def visit_node(cursor):
            if cursor.kind == CursorKind.FUNCTION_DECL and cursor.spelling == target_function:
                if cursor.is_definition():
                    self.target_cursor = cursor
                    return True
                elif not self.target_cursor:  # Keep declaration as backup
                    self.target_cursor = cursor
            
            for child in cursor.get_children():
                if visit_node(child):
                    return True
            return False
        
        visit_node(tu.cursor)
        return self.target_cursor is not None
    
    def find_function_in_files(self, files, target_function):
        """Look for the target function across multiple files."""
        for file_path in files:
            if not os.path.exists(file_path):
                continue
                
            if not file_path.endswith(('.c', '.h', '.cpp', '.hpp')):
                continue
                
            print(f"Searching for {target_function} in {file_path}")
            tu = self.parse_file(file_path)
            if tu and self.find_function_in_tu(tu, target_function):
                print(f"Found {target_function} in {file_path}")
                self.target_file = file_path
                # If we found a definition, we're done
                if self.target_cursor.is_definition():
                    return file_path
        
        # If we only found a declaration, still return the file
        if self.target_cursor:
            return self.target_cursor.location.file.name
            
        return None
    
    def extract_code_range(self, file_path, start_line, end_line):
        """Extract a range of lines from a file."""
        try:
            with open(file_path, 'r') as f:
                lines = f.readlines()
                # Lines are 1-indexed in Clang
                return ''.join(lines[start_line-1:end_line])
        except Exception as e:
            print(f"Error extracting code: {e}")
            return ""
    
    def analyze_type_usage(self, cursor):
        """Analyze which types are used by a node."""
        # Get the type of this cursor
        cursor_type = cursor.type
        if cursor_type.kind != TypeKind.INVALID:
            # Get the canonical type (resolves typedefs)
            canonical_type = cursor_type.get_canonical()
            
            # If it's a pointer or array, get the pointee type
            if canonical_type.kind in (TypeKind.POINTER, TypeKind.CONSTANTARRAY, TypeKind.INCOMPLETEARRAY):
                pointee_type = canonical_type.get_pointee().get_canonical()
                if pointee_type.kind == TypeKind.RECORD:
                    decl = pointee_type.get_declaration()
                    if decl.spelling:
                        self.used_types.add(decl.spelling)
            
            # If it's a record type (struct/union)
            elif canonical_type.kind == TypeKind.RECORD:
                decl = canonical_type.get_declaration()
                if decl.spelling:
                    self.used_types.add(decl.spelling)
            
            # If it's an enum type
            elif canonical_type.kind == TypeKind.ENUM:
                decl = canonical_type.get_declaration()
                if decl.spelling:
                    self.used_enums.add(decl.spelling)
        
        # If it's a typedef declaration, track it
        if cursor.kind == CursorKind.TYPEDEF_DECL and cursor.spelling:
            self.used_typedefs.add(cursor.spelling)
            # Also analyze the underlying type
            for child in cursor.get_children():
                self.analyze_type_usage(child)
        
        # If it's a struct field reference, track which fields are used
        if cursor.kind == CursorKind.MEMBER_REF_EXPR:
            parent_expr = list(cursor.get_children())[0] if list(cursor.get_children()) else None
            if parent_expr:
                parent_type = parent_expr.type.get_canonical()
                if parent_type.kind == TypeKind.POINTER:
                    parent_type = parent_type.get_pointee().get_canonical()
                
                if parent_type.kind == TypeKind.RECORD:
                    struct_name = parent_type.get_declaration().spelling
                    if struct_name:
                        if struct_name not in self.used_struct_fields:
                            self.used_struct_fields[struct_name] = set()
                        self.used_struct_fields[struct_name].add(cursor.spelling)
        
        # Recursively check children
        for child in cursor.get_children():
            self.analyze_type_usage(child)
    
    def analyze_function_calls(self, cursor):
        """Analyze which functions are called by a node."""
        if cursor.kind == CursorKind.CALL_EXPR:
            called_func = cursor.referenced
            if called_func and called_func.spelling:
                self.used_functions.add(called_func.spelling)
                self.used_function_cursors[called_func.spelling] = called_func
        
        # Recursively check children
        for child in cursor.get_children():
            self.analyze_function_calls(child)
    
    def analyze_macro_usage(self, cursor, file_path):
        """Analyze which macros are used."""
        # This is tricky with Clang's Python bindings as macro references aren't easily tracked
        # As a fallback, we'll extract the function text and do a basic text search for all defined macros
        if cursor.kind == CursorKind.FUNCTION_DECL and cursor.is_definition():
            function_text = self.extract_code_range(
                cursor.location.file.name, 
                cursor.extent.start.line, 
                cursor.extent.end.line
            )
            
            # Find all macro definitions in the translation unit
            tu = self.parse_file(file_path)
            if tu:
                for c in tu.cursor.walk_preorder():
                    if c.kind == CursorKind.MACRO_DEFINITION:
                        macro_name = c.spelling
                        # Simple check: if the macro name appears in the function text
                        # This is imperfect but catches most uses
                        if re.search(r'\b' + re.escape(macro_name) + r'\b', function_text):
                            self.used_macros.add(macro_name)
                            
                            # Store the macro definition
                            if macro_name not in self.macro_defs and c.location.file:
                                start = c.extent.start.line
                                end = c.extent.end.line
                                code = self.extract_code_range(c.location.file.name, start, end)
                                self.macro_defs[macro_name] = code
    
    def collect_precise_dependencies(self):
        """Collect only the dependencies actually used by the target function."""
        if not self.target_cursor:
            print("Error: Target function not found.")
            return
            
        print(f"Analyzing dependencies for {self.target_cursor.spelling}...")
        
        # Start by analyzing the target function
        self.analyze_type_usage(self.target_cursor)
        self.analyze_function_calls(self.target_cursor)
        self.analyze_macro_usage(self.target_cursor, self.target_file)
        
        # Process called functions recursively
        function_queue = deque(self.used_functions)
        processed_functions = set()
        
        while function_queue:
            func_name = function_queue.popleft()
            
            if func_name in processed_functions:
                continue
                
            processed_functions.add(func_name)
            
            # If we have this function's cursor, analyze it
            if func_name in self.used_function_cursors:
                func_cursor = self.used_function_cursors[func_name]
                
                if func_cursor.is_definition():
                    self.analyze_type_usage(func_cursor)
                    self.analyze_function_calls(func_cursor)
                    
                    if func_cursor.location.file:
                        self.analyze_macro_usage(func_cursor, func_cursor.location.file.name)
                    
                    # Store the function definition
                    if func_name not in self.function_defs and func_cursor.location.file:
                        start = func_cursor.extent.start.line
                        end = func_cursor.extent.end.line
                        code = self.extract_code_range(func_cursor.location.file.name, start, end)
                        self.function_defs[func_name] = code
                else:
                    # Store the function declaration
                    if func_name not in self.function_decls and func_cursor.location.file:
                        start = func_cursor.extent.start.line
                        end = func_cursor.extent.end.line
                        code = self.extract_code_range(func_cursor.location.file.name, start, end)
                        self.function_decls[func_name] = code
                    
                    # Try to find the definition
                    self._find_function_definition(func_name)
                
                # Add newly discovered function calls to the queue
                for new_func in self.used_functions - processed_functions:
                    if new_func not in function_queue:
                        function_queue.append(new_func)
            else:
                # Try to find this function in the codebase
                self._find_function_definition(func_name)
        
        # Collect all used struct/union/enum/typedef definitions
        self._collect_type_definitions()
    
    def _find_function_definition(self, function_name):
        """Find the definition of a function in the codebase."""
        if function_name in self.function_defs:
            return  # Already have it
            
        print(f"Looking for definition of {function_name}...")
        
        # Search for the function in the codebase
        for root, _, files in os.walk(self.project_root):
            for file in files:
                if not file.endswith('.c'):
                    continue
                    
                file_path = os.path.join(root, file)
                tu = self.parse_file(file_path)
                
                if not tu:
                    continue
                    
                # Look for the function definition
                def find_func(cursor):
                    if cursor.kind == CursorKind.FUNCTION_DECL and cursor.spelling == function_name:
                        if cursor.is_definition():
                            # Found it! Store the definition
                            start = cursor.extent.start.line
                            end = cursor.extent.end.line
                            code = self.extract_code_range(cursor.location.file.name, start, end)
                            self.function_defs[function_name] = code
                            
                            # Analyze this function too
                            self.analyze_type_usage(cursor)
                            self.analyze_function_calls(cursor)
                            self.analyze_macro_usage(cursor, file_path)
                            
                            # Add the cursor to our collection
                            self.used_function_cursors[function_name] = cursor
                            
                            print(f"Found definition for {function_name} in {file_path}")
                            return True
                            
                    for child in cursor.get_children():
                        if find_func(child):
                            return True
                    return False
                    
                if find_func(tu.cursor):
                    return  # Found it!
    
    def _collect_type_definitions(self):
        """Collect definitions for all used types."""
        # Look through all source files for the type definitions
        for root, _, files in os.walk(self.project_root):
            for file in files:
                if not file.endswith(('.c', '.h')):
                    continue
                    
                file_path = os.path.join(root, file)
                tu = self.parse_file(file_path)
                
                if not tu:
                    continue
                    
                # Look for type definitions
                for cursor in tu.cursor.walk_preorder():
                    # Check for struct/union definitions
                    if cursor.kind in (CursorKind.STRUCT_DECL, CursorKind.UNION_DECL) and cursor.spelling:
                        if cursor.spelling in self.used_types:
                            # Store the struct definition
                            key = f"{cursor.kind}_{cursor.spelling}"
                            if key not in self.struct_decls and cursor.location.file:
                                start = cursor.extent.start.line
                                end = cursor.extent.end.line
                                code = self.extract_code_range(cursor.location.file.name, start, end)
                                self.struct_decls[key] = code
                    
                    # Check for enum definitions
                    elif cursor.kind == CursorKind.ENUM_DECL and cursor.spelling:
                        if cursor.spelling in self.used_enums:
                            # Store the enum definition
                            key = f"ENUM_{cursor.spelling}"
                            if key not in self.enum_decls and cursor.location.file:
                                start = cursor.extent.start.line
                                end = cursor.extent.end.line
                                code = self.extract_code_range(cursor.location.file.name, start, end)
                                self.enum_decls[key] = code
                    
                    # Check for typedef definitions
                    elif cursor.kind == CursorKind.TYPEDEF_DECL:
                        if cursor.spelling in self.used_typedefs:
                            # Store the typedef definition
                            key = f"TYPEDEF_{cursor.spelling}"
                            if key not in self.typedef_decls and cursor.location.file:
                                start = cursor.extent.start.line
                                end = cursor.extent.end.line
                                code = self.extract_code_range(cursor.location.file.name, start, end)
                                self.typedef_decls[key] = code
    
    def generate_minimal_file(self, target_function):
        """Generate a minimal file with only the necessary dependencies."""
        if not self.target_cursor:
            print(f"Error: Function {target_function} not found.")
            return None
        
        # First, collect all the precise dependencies
        self.collect_precise_dependencies()
        
        # Start building output
        output = []
        
        # Add standard headers
        output.append("/* Generated minimal test case for function: {} */".format(target_function))
        output.append("#include <stdio.h>")
        output.append("#include <stdlib.h>")
        output.append("#include <string.h>")  # Often needed
        output.append("#include <time.h>")    # For timing
        output.append("")
        
        # Add macro definitions that are actually used
        if self.macro_defs:
            output.append("/* Required macro definitions */")
            for macro_name, macro_code in self.macro_defs.items():
                if macro_name in self.used_macros and macro_code and len(macro_code.strip()) > 0:
                    output.append(macro_code)
            output.append("")
        
        # Add typedefs that are actually used
        if self.typedef_decls:
            output.append("/* Required typedefs */")
            for typedef_key, typedef_code in self.typedef_decls.items():
                if typedef_code and len(typedef_code.strip()) > 0:
                    output.append(typedef_code)
            output.append("")
        
        # Add struct/union definitions that are actually used
        if self.struct_decls:
            output.append("/* Required struct/union definitions */")
            for struct_key, struct_code in self.struct_decls.items():
                if struct_code and len(struct_code.strip()) > 0:
                    output.append(struct_code)
            output.append("")
        
        # Add enum definitions that are actually used
        if self.enum_decls:
            output.append("/* Required enum definitions */")
            for enum_key, enum_code in self.enum_decls.items():
                if enum_code and len(enum_code.strip()) > 0:
                    output.append(enum_code)
            output.append("")
        
        # Add function declarations for dependencies
        if self.function_decls:
            output.append("/* Function declarations */")
            for func_name, decl in self.function_decls.items():
                if func_name in self.used_functions and func_name not in self.function_defs:
                    if decl and len(decl.strip()) > 0:
                        output.append(decl)
            output.append("")
        
        # Add function definitions (excluding the target)
        if self.function_defs:
            output.append("/* Required function implementations */")
            for func_name, def_code in self.function_defs.items():
                if func_name in self.used_functions and func_name != target_function:
                    if def_code and len(def_code.strip()) > 0:
                        output.append(def_code)
                        output.append("")
        
        # Add the target function implementation
        output.append("/* Target function */")
        if self.target_cursor.is_definition():
            start = self.target_cursor.extent.start.line
            end = self.target_cursor.extent.end.line
            target_code = self.extract_code_range(self.target_cursor.location.file.name, start, end)
            output.append(target_code)
        else:
            # If we only have a declaration, add a stub implementation
            output.append(f"/* WARNING: Only found declaration for {target_function}, implementation needs to be added */")
            if target_function in self.function_decls:
                output.append(self.function_decls[target_function])
                output.append("{")
                output.append("    /* TODO: Add implementation */")
                output.append("}")
        output.append("")
        
        # Add a test harness
        output.append("/* Test harness */")
        output.append("int main() {")
        output.append("    /* TODO: Initialize any required data structures */")
        output.append("    ")
        output.append("    /* Performance measurement */")
        output.append("    clock_t start = clock();")
        output.append("    ")
        output.append("    /* Run the function many times for benchmarking */")
        output.append("    for (int i = 0; i < 1000000; i++) {")
        output.append(f"        {target_function}(/* TODO: Add appropriate parameters */);")
        output.append("    }")
        output.append("    ")
        output.append("    clock_t end = clock();")
        output.append("    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;")
        output.append("    printf(\"Time spent: %f seconds\\n\", time_spent);")
        output.append("    ")
        output.append("    return 0;")
        output.append("}")
        
        return '\n'.join(output)

def find_c_files(directory, recursive=True):
    """Find all C source files in a directory."""
    c_files = []
    
    if recursive:
        for root, _, files in os.walk(directory):
            for file in files:
                if file.endswith(('.c', '.h')):
                    c_files.append(os.path.join(root, file))
    else:
        for file in os.listdir(directory):
            if file.endswith(('.c', '.h')):
                c_files.append(os.path.join(directory, file))
    
    return c_files

def main():
    if len(sys.argv) < 3:
        print("Usage: python precise_extract.py project_root function_name [--output output_file]")
        print("Options:")
        print("  --output output_file    Specify output file (default: function_name_minimal.c)")
        print("  --no-recursive          Don't search subdirectories")
        return 1
    
    project_root = sys.argv[1]
    target_function = sys.argv[2]
    
    # Parse options
    output_file = f"{target_function}_minimal.c"
    recursive = True
    
    if "--output" in sys.argv:
        idx = sys.argv.index("--output")
        if idx + 1 < len(sys.argv):
            output_file = sys.argv[idx + 1]
    
    if "--no-recursive" in sys.argv:
        recursive = False
    
    # Initialize extractor
    extractor = PreciseExtractor(project_root)
    
    # Find source files
    files = find_c_files(project_root, recursive)
    print(f"Found {len(files)} source files in {project_root}")
    
    # Find the target function
    source_file = extractor.find_function_in_files(files, target_function)
    
    if not source_file:
        print(f"Error: Could not find function '{target_function}' in any source file.")
        return 1
    
    # Generate minimal file
    print(f"Generating minimal file for function '{target_function}'...")
    minimal_code = extractor.generate_minimal_file(target_function)
    
    if minimal_code:
        with open(output_file, 'w') as f:
            f.write(minimal_code)
        print(f"Successfully extracted minimal version to {output_file}")
        print("Note: You may need to manually adjust function prototypes and test data.")
    else:
        print("Error: Failed to generate minimal file.")
        return 1
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
'''
