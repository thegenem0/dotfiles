if [[ "$ZPROF" = true ]]; then
zmodload zsh/zprof
fi

ZSH_CUSTOM=~/.zsh

fpath=(
  ~/.zsh/completion
    $fpath
)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.scripts/antigen.zsh

antigen use oh-my-zsh

antigen theme romkatv/powerlevel10k

antigen bundle reegnz/aws-vault-zsh-plugin
antigen bundle git
antigen bundle npm
antigen bundle encode64
antigen bundle colorize
antigen bundle github
antigen bundle bundler
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle Aloxaf/fzf-tab
antigen bundle atuinsh/atuin@main
antigen bundle MichaelAquilina/zsh-auto-notify
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle reegnz/jq-zsh-plugin
antigen bundle aubreypwd/zsh-plugin-reload
antigen bundle qoomon/zsh-lazyload

antigen apply

autoload -U compinit
compinit

fastfetch
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##############################################################################
# History Configuration
##############################################################################
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

# aliases
alias gl="lazygit"
alias gowork="cd ~/dev/hace/"
alias gome="cd ~/dev/personal"
alias vim="nvim"

alias ls='exa --icons --long --git -h --group-directories-first'

alias tf="terraform"

alias cli-nosession="aws-vault exec hace-cli --no-session --"
alias main-nosession="aws-vault exec hace-main --no-session --"

alias init-hace="git config user.email "gergo@thisishace.com" && git config user.name "gergo-at-hace""
alias init-me="git config user.email "nemethgergo02@gmail.com" && git config user.name "thegeneme0""


lst() {
    tree -L $1
}

profzsh() {
  shell=${1-$SHELL}
  ZPROF=true $shell -i -c exit
}

load-nvm() {
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
}

nvm() {
    unset -f nvm
    load-nvm
    nvm "$@"
}

node() {
    unset -f node
    load-nvm
    node "$@"
}

npm() {
    unset -f npm
    load-nvm
    npm "$@"
}

pnpm() {
    unset -f pnpm
    load-nvm
    pnpm "$@"
}

yarn() {
    unset -f yarn
    load-nvm
    yarn "$@"
}

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

export EDITOR="nvim"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/thegenem0/google-cloud-sdk/path.zsh.inc' ]; then . '/home/thegenem0/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/thegenem0/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/thegenem0/google-cloud-sdk/completion.zsh.inc'; fi

source "/home/thegenem0/.sdkman/bin/sdkman-init.sh"

if [[ "$ZPROF" = true ]]; then
  zprof
fi
