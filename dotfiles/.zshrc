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

##Bindings
bindkey "^[[1;5D" emacs-backward-word
bindkey "^[[1;5C" emacs-forward-word

##OPTIONS
WORDCHARS=${WORDCHARS/\/} #treat \ as word
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
#PS1
host_prompt="%F{39}%m%"
set_ps1() { 
    directory_prompt=":%F{111}"`pwd | sed "s/\/\home\/mingo/~/g" | sed "s:\([^/]\)[^/]*/:\1/:g"`
    PS1="$host_prompt $directory_prompt "
}
chpwd_functions+=( set_ps1 )
set_ps1

#alias
autoload -U zmv
alias mmv='noglob zmv -W'
alias ls='ls --color'
alias palette='for i in {0..255}; do echo -e "\e[38;05;${i}m${i}"; done | column -c 180 -s "  "; echo -e "\e[m"'

##Plugins setting
# zsh-history-substring-search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^k" history-substring-search-up
bindkey "^j" history-substring-search-down

# zsh-dirhistory
bindkey "^[[1;3D" dirhistory_zle_dirhistory_back
bindkey "^[[1;3C" dirhistory_zle_dirhistory_future

# zsh-autosuggestions
zle-line-init() { zle autosuggest-start }
zle -N zle-line-init


PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/game" 
#Customize site path in ~/.zsh_site_env
source $HOME/.zsh_site_env 2> /dev/null
export PATH=$SITE_PATH:$PATH

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
