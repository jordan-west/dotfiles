# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
source ~/bin/.git-completion.bash
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
source ~/bin/.git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWCOLORHINTS=true

# Set up the prompt (credit to https://github.com/noopkat) 
export PS1='👾\[\e[0;36m\]\[\e[0;36m\]  \w\[\033[0;35m\]$(__git_ps1 " (%s)")\[\e[0m\]: '
