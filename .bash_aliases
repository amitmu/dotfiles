
#alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A --group-dirs first'
#alias l='ls -CF'

alias ls='lsd'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ltr='ls -ltrhA --group-dirs first'
alias la='ls -A --group-dirs first'
#alias lx='exa -aligHhS --color=always --group-directories-first'
alias lx='ls -lShA --total-size'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#for dotfiles.git bare repo
alias dotfiles='git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'
