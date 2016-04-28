# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

LLRGATE()
{
   gate=llrgate01
   polui=polui07
   nargs=$#
   if [ $nargs -gt 0 ]; then
      gate=llrgate0$1
   else
      echo 'using default gate: 01'
   fi
   if [ $nargs -gt 1 ]; then
      polui=polui0$2
   else
      echo 'using default polui: 07'
   fi
   echo $gate $polui $nargs
   ssh -t trant@${gate}.in2p3.fr ssh ${polui}.in2p3.fr
}

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# funcs
REMOTEMOUNT()
{
#export emptiness=`[ "$(ls -A polui07)" ] && echo "Not Empty" || echo "Empty"`
   echo "mount $1 -> $2"
   export nfiles=`ls -1A $2 | wc -l`
   if [ $nfiles == 0 ]; then
      sshfs $1 $2
   else
      echo "Not Empty: $2"
   fi
}

#IMOUNT()
#{
#   REMOTEMOUNT 'trant@polui07.in2p3.fr:' polui07
#   REMOTEMOUNT 'trant@polui07.in2p3.fr:/data_ilc/flc/tran' data_ilc
#   REMOTEMOUNT 'trant@polui07.in2p3.fr:/data_ilc/flc' data_ilc0
#}
IMOUNT()
{
   REMOTEMOUNT 'trant@polui01.in2p3.fr:' polui07
   REMOTEMOUNT 'trant@polui01.in2p3.fr:/data_ilc/flc/tran' data_ilc
   REMOTEMOUNT 'trant@polui01.in2p3.fr:/data_ilc/flc' data_ilc0
}
JMOUNT()
{
   REMOTEMOUNT 'trant@llrgate01.in2p3.fr:' polui07
   REMOTEMOUNT 'trant@llrgate01.in2p3.fr:/grid_mnt/data__DATA/data.polcalice/data/flc/tran' data_ilc
#   REMOTEMOUNT 'trant@llrgate01.in2p3.fr:/grid_mnt/data__DATA/data.polcalice/data/flc' data_ilc0
}
stopMOUNT()
{
   umount -l data_ilc0
   umount -l data_ilc
   umount -l polui07
}
ROTATEPDF()
{
   pdftk $1 cat 1east output $2
}

# some more ls aliases
alias bk='~/bin/python/bk.v2.py'
alias briss='java -jar ~/Softs/Briss/briss-0.9/briss-0.9.jar'
alias ccompile='~/bin/compile'
alias data='cd /mnt/DATA/DataSci/'
alias destr='rm -f *~'
#alias imount='sshfs trant@polui07.in2p3.fr: polui07'
alias gate1='ssh -XY trant@llrgate01.in2p3.fr'
alias gate2='ssh -XY trant@llrgate02.in2p3.fr'
alias grammarcheck='~/polui07/doc/CheckWriting/Academic-Writing-Check-master/checkwriting'
alias imount='IMOUNT'
alias imim='cd /mnt/DATA/ImIm'
alias jabref='java -jar ~/Softs/jabref/JabRef-2.10.jar'
alias jmount='JMOUNT'
alias l='ls -CF'
alias la='ls -A'
alias lo='libreoffice'
alias ll='ls -alF'
alias llrgate='LLRGATE'
alias ltr='ls -ltrh'
alias lx6='ssh trtran@lxplus.cern.ch'
alias ma='make all'
alias mklatex='~/bin/MakeLatex'
#alias imount='sshfs trant@polui07.in2p3.fr:/data_ilc/flc/tran data_ilc'
alias pol7='ssh -XY trant@polui07.in2p3.fr'
alias pol4='ssh -XY trant@polui04.in2p3.fr'
alias pol1='ssh -XY trant@polui01.in2p3.fr'
alias rotatepdf='ROTATEPDF'
alias stopMount='stopMOUNT'
alias tp='top -u hieu'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#export ROOTSYS="/home/hieu/Softs/root/6.02.01"
#export PATH=$PATH:$ROOTSYS/bin

#export LCIOVER=v02-04-03
export LCIOVER=v02-05

export TEXINPUTS=$TEXINPUTS:/home/hieu/polui07/doc/tex/extsizes:/home/hieu/data_ilc/doc/CVs/moderncv/moderncv:/home/hieu/data_ilc/doc/CVs/moderncv:/home/hieu/data_ilc/doc/CVs/actRes/mdframed

export PATH=$PATH:/home/hieu/Softs/lcio/$LCIOVER/bin
export PATH=$LCIO/bin:$LCIO/tools:$PATH
export LCIO=/home/hieu/Softs/lcio/$LCIOVER
export PYTHONPATH=$LCIO/src/python:$PYTHONPATH
export PYTHONPATH=/home/hieu/Softs/root/5.34.23/lib:$PYTHONPATH
export PYTHONPATH=$PYTHONPATH:/home/hieu/Softs/python/xgboost/python-package

unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH="$LCIO/lib:$LD_LIBRARY_PATH"

ROOTVER=5.34.23
#ROOTVER=6.02.01
ROOTDIR=/home/hieu/Softs/root
export ROOTSYS=$ROOTDIR/$ROOTVER
export PATH="$ROOTSYS/bin:$PATH"
export LD_LIBRARY_PATH="$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH"

export DRUIDDIR=/home/hieu/Softs/ilc/Druid/2.1-b
export DRUID=/home/hieu/Softs/ilc/Druid/2.1-b
export PATH=$PATH:$DRUIDDIR/bin

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export NLS_LANG=`$ORACLE_HOME/bin/nls_lang.sh`
export ORACLE_BASE=/u01/app/oracle
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
export PATH=$ORACLE_HOME/bin:$PATH


# added by Anaconda2 4.0.0 installer
export PATH="/home/hieu/Softs/Anaconda2/bin:$PATH"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/hieu/Softs/Anaconda2/lib:/home/hieu/Softs/Anaconda2/pkgs/mkl-11.3.1-0/lib
