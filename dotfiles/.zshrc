ZGEN_HOME=$HOME/.zgen 
if ! [[ -d $ZGEN_HOME ]]
then
    git clone git@github.com:tarjoilija/zgen.git $ZGEN_HOME
fi
source "$ZGEN_HOME/zgen.zsh"
if ! zgen saved; then
    echo "Creating a zgen save"
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/zsh-history-substring-search

    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-completions src

    zgen oh-my-zsh themes/arrow
    # save all to init script
    zgen save
fi


DEFAULTPATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games" 
function addPath(){
    if (( $# == 0 ))
    then
        export PATH=$DEFAULTPATH
    else
        export PATH=$1:$PATH
    fi
}

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


#DEFAULT
addPath
#CUDA
export CUDA_HOME=/usr/local/cuda-7.0 
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64 
addPath $CUDA_HOME/bin
#NVIM
#addSubPath $HOME/.nvim/rplugin


#nvim chpwd hook
neovim_autocd() {
    [ $NVIM_LISTEN_ADDRESS ] && neovim-autocd.py
}
#chpwd_functions+=( neovim_autocd )

#alias
autoload -U zmv
alias mmv='noglob zmv -W'

#Finally, onmyzsh
source $ZSH/oh-my-zsh.sh
