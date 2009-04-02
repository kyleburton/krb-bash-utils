#
# Git Prompt, based off of 
#
function git_pwd_is_tracked {
   [ $(git log -1 --pretty=oneline  . | wc -l) -eq "1" ]
}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  if git_pwd_is_tracked; then
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
  else
    printf "[---]"
  fi
}

export PS1='\u@\h \[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '
