##ANTIGEN
GEN_HOME=$HOME/.antigen
if ! [[ -d $GEN_HOME ]]
then
git clone https://github.com/zsh-users/antigen.git $GEN_HOME
fi
source "$GEN_HOME/antigen.zsh"
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle tarruda/zsh-autosuggestions
antigen bundle ipod825/zsh-dirhistory

##OPTIONS
#General
autoload -U zmv
WORDCHARS=${WORDCHARS/\/} #treat \ as word

#Bindings
bindkey -M viins jk vi-cmd-mode 
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
bindkey -M vicmd "^[h" beginning-of-line
bindkey -M vicmd "^[l" end-of-line
bindkey "^k" history-substring-search-up
bindkey "^j" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[h" beginning-of-line
bindkey "^[l" end-of-line
bindkey "^_" backward-delete-char #actually this is ^?
bindkey "^[_" forward-delete-char


#bindkey "^b" dirhistory_zle_dirhistory_back
#bindkey "^f" dirhistory_zle_dirhistory_future

#zle
zle-line-init() { zle autosuggest-start }
zle -N zle-line-init

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

#alias
alias mmv='noglob zmv -W'
alias ls='ls --color'
alias palette='for i in {0..255}; do echo -e "\e[38;05;${i}m${i}"; done | column -c 180 -s "  "; echo -e "\e[m"'

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

#Path
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/game" 
source $HOME/.zsh_site_env 2> /dev/null #Customize site path in ~/.zsh_site_env
export PATH=$SITE_PATH:$PATH

#autosuggest
AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=245'



function addSubPath(){
    root=$1
    for f in `ls $root`
    do
        dir=$root/$f
        if [ -d $dir ]; then
            export PATH=$dir:$PATH
        fi
    done
}
#NVIM_LISTEN_ADDRESS="/tmp/nvim"
#nvim_autocd() {
#    [ $NVIM_LISTEN_ADDRESS ] && $HOME/.nvim/bundle/nvim-autocd/rplugin/python/nvim-autocd.py
#}
#chpwd_functions+=( nvim_autocd )
#
