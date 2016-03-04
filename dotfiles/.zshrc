##ANTIGEN
GEN_HOME=$HOME/.antigen
if ! [[ -d $GEN_HOME ]]
then
git clone https://github.com/zsh-users/antigen.git $GEN_HOME
fi
source "$GEN_HOME/antigen.zsh"
antigen bundle tarruda/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

##OPTIONS
#General
autoload -U zmv
WORDCHARS=${WORDCHARS/\/} #treat \ as word

#alias
alias mmv='noglob zmv -W'
alias ls='ls --color'
alias palette='for i in {0..255}; do echo -e "\e[38;05;${i}m${i}"; done | column -c 180 -s "  "; echo -e "\e[m"'

#Path
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/game:$HOME/.fzf/bin" 
source $HOME/.zsh_site_env 2> /dev/null #Customize site path in ~/.zsh_site_env
export PATH=$SITE_PATH:$PATH

#completion
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#history
HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
setopt HIST_NO_STORE #history does not store history command
setopt APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_SAVE_NO_DUPS  HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY # Save the time and how long a command ran

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

#Bindings
bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[h" beginning-of-line
bindkey "^[l" end-of-line

#Plugins
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(end-of-line)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(forward-char forward-word)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
ZSH_AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=245'

ZSH_HIGHLIGHT_STYLES[globbing]=fg=11

#PS1
host_prompt="%F{39}%m"
set_ps1() { 
    sedcmd="s/\/\home\/$USER/~/g"
    directory_prompt=":%F{111}"`pwd | sed $sedcmd | sed "s:\([^/]\)[^/]*/:\1/:g"`
    #VI_MODE="${${KEYMAP/vicmd/[N]}/(main|viins)/[I]}"
    PS1="$VI_MODE$host_prompt $directory_prompt "
}
set_ps1_chpwd() { KEYMAP="viins" && set_ps1 }
chpwd_functions+=( set_ps1_chpwd )
set_ps1_chpwd

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
