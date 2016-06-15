##ANTIGEN
GEN_HOME=$HOME/.zgen
if ! [[ -d $GEN_HOME ]]
then
git clone https://github.com/tarjoilija/zgen.git $GEN_HOME
fi
source "$GEN_HOME/zgen.zsh"
if ! zgen saved; then
    echo "Creating a zgen save"
    zgen load tarruda/zsh-autosuggestions
    zgen load zsh-users/zsh-completions
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-history-substring-search
    zgen load psprint/zsh-navigation-tools
    zgen save
fi


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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#Plugins
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(end-of-line)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(forward-char forward-word)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

ZSH_HIGHLIGHT_STYLES[globbing]=fg=11

# FZF
# vimf - Open selected file in Vim
nvimf() {
  local file
  file=$(fzf --query="$1") && nvim "$file"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fh - repeat history
fh() {
  eval $(history | fzf +s | sed 's/ *[0-9]* *//')
}

# fkill - kill process
fkill() {
  ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
}

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf +s +m) &&
  git checkout $(echo "$branch" | sed "s/.* //")
}

# fco - checkout git commit
fco() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
    line=$(grep -v "^!" tags | cut -f1-3 | cut -c1-80 | fzf --nth=1) &&
    $EDITOR $(cut -f2 <<< "$line")
}

# fq1 [QUERY]
# - Immediately select the file when there's only one match.
#   If not, start the fuzzy finder as usual.
fq1() {
  local lines
  lines=$(fzf --filter="$1" --no-sort)
  if [ -z "$lines" ]; then
    return 1
  elif [ $(wc -l <<< "$lines") -eq 1 ]; then
    echo "$lines"
  else
    echo "$lines" | fzf --query="$1"
  fi
}

# fe [QUERY]
# - Open the selected file with the default editor
#   (Bypass fuzzy finder when there's only one match)
fe() {
  local file
  file=$(fq1 "$1") && ${EDITOR:-nvim} "$file"
}
