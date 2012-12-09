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

# I like vim.
export EDITOR=vim
alias vi=vim
alias l=ls
