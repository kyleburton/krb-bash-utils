#
# Git Prompt, based off of http://henrik.nyh.se/2008/12/git-dirty-prompt
#


# emits '-' if the pwd is untracked, otherwise nothing
function git_pwd_is_tracked {
   [ $(git log -1 --pretty=oneline . 2>/dev/null | wc -l) -eq "1" ] || echo "<-"
}

# Emits `*' if the current repository is `dirty' (untracked files or uncommited changes in the index)
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

# Emits the name of the current git branch or `---' if the pwd is untracked
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[$(git_pwd_is_tracked)\1$(parse_git_dirty)]/"
}

export PS1='\u@\h \[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '
