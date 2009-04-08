# my find shortcuts

function find_filter () {
  grep -v .svn/ | grep -v ^.git/ | grep -v /CVS/
}

# 'find file'
function ff () {
  DIR="."
  if [ -d "$1" ]; then
    DIR="$1"
    shift
  fi

  if [[ "$1" == -* ]]; then
    #echo "dash arg..."
    find "$DIR" -type f "$@" | find_filter
  elif [ -z "$1" ]; then
    #echo "no arg..."
    find "$DIR" -type f | find_filter
  else
    #echo "many args..."
    PAT="$1"
    shift
    find "$DIR" -type f -name "*$PAT*" "$@" | find_filter
  fi
}

# find directory
function fd () {
  DIR="."
  if [ -d "$1" ]; then
    DIR="$1"
    shift
  fi

  if [[ "$1" == -* ]]; then
    #echo "dash arg..."
    find "$DIR" -type d "$@" | find_filter
  elif [ -z "$1" ]; then
    #echo "no arg..."
    find "$DIR" -type d | find_filter
  else
    #echo "many args..."
    PAT="$1"
    shift
    find "$DIR" -type d -name "*$PAT*" "$@" | find_filter
  fi
}

# find file xargs grep
function ffxg () {
  DIR="."
  if [ -d "$1" ]; then
    DIR="$1"
    shift
  fi

  PAT="$1"
  shift

  ff "$DIR" 2>&1 | xargs grep "$@" "$PAT" 2>&1 | less -p "$PAT"
}


# shorhand for xargs grep
function xg () {
  PAT="$1"
  shift
  xargs grep "$@" "$PAT" 2>&1 | less -p "$PAT"
}

