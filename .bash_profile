# Better prompt, in color and showing current git branch

function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " "${ref#refs/heads/}
}

COLOR_BLACK="0"
COLOR_BLUE="4"
COLOR_GREEN="2"
COLOR_CYAN="6"
COLOR_RED="1"
COLOR_PURPLE="5"
COLOR_BROWN="3"
COLOR_GRAY="7"

# Show hostname in user-specified color

function ps_color {
  if [ -z "$TERM" ]; then
    export TERM="xterm-color"
  fi
  if [ -n "${PSBOLD}" ]; then
    tput bold
  fi
  if [ -n "${PSUNDERLINE}" ]; then
    tput smul
  fi
  if [ -z "${PSCOLOR}" ]; then
    tput setaf $COLOR_BLUE
  else
    tput setaf $PSCOLOR
  fi
}

function ps_hostname {
  if [ -z "${PSHOST}" ]; then
    PSHOST=`hostname | cut -d'.' -f1`
  fi
  echo "$PSHOST"
}

export PS1="\[\$(ps_color)\]\$(ps_hostname)\[$(tput sgr0)\]:\w\[\033[1;37m\]\$(parse_git_branch)\[\033[0;00m\] \u\$ "

# Add local ~/bin to PATH if it exists

if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# Additional utilities

# This one depends on csvkit https://csvkit.readthedocs.io/
#    and dos2unix https://formulae.brew.sh/formula/dos2unix
function csvhead() {
  local lines="$2"
  local csvlookflags="$3"
  [ -z "$lines" ] && lines="50"
  head -n "$lines" "$1" | dos2unix | csvlook $3 | less -S
}

# Restart launchctl daemons on Mac OS X (required after editing the .plist)
function launchctl_restart() {
  sudo launchctl unload "$1"
  sudo launchctl load -w "$1"
}

# 7zip tools
alias 7zencrypt='7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on -mhe=on -p'
alias 7ztest='7z l -slt'

# When I use R, I never save the workspace on exiting
alias R="R --no-save"

# Run a jupyter notebook top to bottom in place
function nbx() {
  local kernel=""
  local nb="$1"
  if [ "$#" -ge 2 ]; then
    kernel="--ExecutePreprocessor.kernel_name=$1"
    nb="$2"
  fi
  jupyter nbconvert --execute --to notebook --inplace --ExecutePreprocessor.timeout=-1 $kernel "$nb"
}

# I like vim.
export EDITOR=vim
alias vi=vim
alias l=ls
