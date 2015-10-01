# Path to your oh-my-zsh installation.
export ZSH=/home/mingo/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

#Completion
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true" #Auto-correction

export UPDATE_ZSH_DAYS=30 #Check update

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)


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
addSubPath $HOME/.nvim/rplugin


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
