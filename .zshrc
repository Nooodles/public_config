# Lines configured by zsh-newuser-install
unsetopt beep
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Load completions
autoload -Uz compinit && compinit

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nicolas/.zshrc'
# End of lines added by compinstall

# History
HISTSIZE=5000
HISTFILE=~/.histfile
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Add brew to path
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# source $(brew --prefix nvm)/nvm.sh

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Completion styling
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# # Aliases
alias ls='ls --color'
alias lla='ls -la'
alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Needed for packages installed via pip
export PATH="$HOME/.local/bin:$PATH"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
   local command=$1
   shift

   case "$command" in
   cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
   export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
   ssh)          fzf --preview 'dig {}'                   "$@" ;;
   *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
   esac
}

# Shell integrations
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/theme.omp.json)"

#eval "$(fzf --zsh)
