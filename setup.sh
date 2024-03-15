# Aliases and functions
alias Q="date && squeue --user jnprice"
alias lh="ls -lh"
alias md="mkdir"
alias rd="rmdir" 
#alias ..="cd .."
#alias ...="cd ../.."
alias duh='du -sh ./* ./.*' # Disk usage with human readable units, including hidden flies and not recursive
alias untar='tar -xvzf' # Easy untar

function mkcd() {
    mkdir -p "$1" && cd "$1"
}

## Safety
alias rm="rm -i"
alias mv='mv -i'
alias cp='cp -i'

## Git aliases
alias gstatus='git status -sb' # Succinct git status
alias gbranch="git checkout -b " # Checkout a new branch

function lazygit() {
		git add .
		git commit -m "$1"
		git push
}

# Helper function to pull + push updates from fork and upstream and clean old branches
function gupdate(){
  local upstream_branch="${1:-dev}"
  local remote_name="origin"
  if git remote | grep -q 'upstream'; then
    remote_name="upstream"
  fi
  echo "Pulling updates from $fg[green]origin/$(git branch --show-current)$fg[default] and $fg[green]${remote_name}/${upstream_branch}$fg[default]"
  git pull
  git pull $remote_name "$upstream_branch"
  git push
  gclean
}

## One command to extract them all
extract () {
  if [ $# -ne 1 ]
  then
    echo "Error: No file specified."
    return 1
  fi
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xvjf $1   ;;
      *.tar.gz)  tar xvzf $1   ;;
      *.bz2)     bunzip2 $1    ;;
      *.rar)     unrar x $1    ;;
      *.gz)      gunzip $1     ;;
      *.tar)     tar xvf $1    ;;
      *.tbz2)    tar xvjf $1   ;;
      *.tgz)     tar xvzf $1   ;;
      *.zip)     unzip $1      ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1       ;;
      *)         echo "'$1' cannot be extracted via extract" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
