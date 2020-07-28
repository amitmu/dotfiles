
if [ -f ~/.cargo/bin/lsd ]; then
  alias ls='lsd'
  alias ltr='ls -ltrhA --group-dirs first'
  alias la='ls -A --group-dirs first'
  #alias lx='exa -aligHhS --color=always --group-directories-first'
  alias lx='ls -lShA --total-size --group-dirs first'
else
  alias ls='ls --color=auto'
  alias ll='ls -alF'
  alias la='ls -ltrhA'
  alias l='ls -CF'
  alias ltr='ls -ltrh --color=auto'
  alias lx='ls -ltrhAS --color=auto --group-directories-first'
fi

#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

# some more ls aliases

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#for dotfiles.git bare repo
alias dotfiles='git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'
