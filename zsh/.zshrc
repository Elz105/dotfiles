# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory
setopt promptsubst

# Git branch info function
git_prompt_info() {
  current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " \033[1;32m($current_branch)\033[0m"
  fi
}

# Set PS1 to include Git branch
PS1='%n@%m %~$(git_prompt_info) %# '

# History settings
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Enable modern completion system
autoload -Uz compinit
compinit
# Add unsetopt BEEP get rid of the damn bell!
unsetopt BEEP
alias ls='ls -ls --color'
alias cls='clear'
alias vgu='vagrant up'
alias vgd='vagrant destroy -f'
alias vags='vagrant suspend'
alias vagr='vagrant resume'
alias venv='python3 -m venv venv && . venv/bin/activate && python3 -m pip install --upgrade pip &>/dev/null'
# Enable Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Configure virtual environment display
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir
  vcs
  virtualenv
  pyenv
)
