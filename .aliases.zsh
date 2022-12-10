setopt rcquotes

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

export DEV_HOME=~/projects
alias wks='cd $DEV_HOME'

#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------

if [ -x "$(command -v colorls)" ]; then
  #alias ls='colorls -h --group-directories-first -1' # colorize `ls` output
  #alias l='colorls --group-directories-first --almost-all'
  #alias ll='colorls --group-directories-first --almost-all --long'

  alias ll='colorls -l --sd' # list with details
  alias ls='colorls --sd' # list
  alias la='colorls -lA --sd' #long list include hidden files/folder
  alias l='colorls -1 --sd' # list- same with ls
  alias lt='colorls --tree=2' #tree view with depth = 2
  alias lf='colorls --files' # show only files
  alias ld='colorls --dirs' # show only dirs 

fi

if [ -x "$(command -v rsync)" ]; then
  alias cpv='rsync -ah --progress'
fi

alias mkdir="mkdir -pv"
alias shtop='sudo htop'        # run `htop` with root rights
alias grep='grep --color=auto' # colorize `grep` output
alias now='date'               # current time
alias less='less -R'

if [ -x "$(command -v git)" ]; then
  alias g='git'
fi

alias ffs='sudo !!' # An alias to rerun the previous command with sudo
alias -g L='| less'
alias -g G='| grep'
alias df='df -H'
alias du='du -sch'
alias wget='wget -c'
alias x='exit'
alias c='clear'
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias o='open .'
fi

#   -----------------------------
#   2.1 Shortcuts
#   -----------------------------

alias zshreload='exec zsh' # reload ZSH
if [ -x "$(command -v mc)" ]; then
  alias edit='mcedit'
fi
alias hs='history | grep'
alias killit='kill -9 $1' # Kill process with -9
alias root='sudo -i'
alias su='sudo -i'
if [ -x "$(command -v java)" ]; then
  alias jj='java -jar'
fi
if [ -x "$(command -v mvn)" ]; then
  alias mcp='mvn clean package'
fi
if [ -x "$(command -v gradle)" ]; then
  alias gcb='gradle clean build'
fi
if [ -x "$(command -v pbcopy)" ]; then
  alias copy='tr -d ''\n'' | pbcopy -selection clipboard'
fi
alias fhere="find . -name "

function cdls() {
  DIR="$*"
  builtin cd "${DIR}" &&
    ls
}

#   -----------------------------
#   2.2 Tools
#   -----------------------------

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias browser=chrome
  alias intellij='open -a IntelliJ\ IDEA'
  alias rider='open -a Rider'
  alias chrome='open -a Google\ Chrome'
  alias firefox='open -a Firefox'
  alias opera='open -a Opera'
  alias safari='open -a Safari'
  alias discord='open -a Discord'
  alias teams='open -a Microsoft\ Teams'
fi
if [ -x "$(command -v lazydocker)" ]; then
  alias lzd='lazydocker'
fi

#   -------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------

alias unzip='extract $*'

function extract() {
  if [ -f $1 ]; then
    case $1 in
    *.tar.bz2) tar xjf $1 ;;
    *.tar.gz) tar xzf $1 ;;
    *.bz2) bunzip2 $1 ;;
    *.rar) unrar e $1 ;;
    *.gz) gunzip $1 ;;
    *.tar) tar xf $1 ;;
    *.tbz2) tar xjf $1 ;;
    *.tgz) tar xzf $1 ;;
    *.zip) unzip $1 ;;
    *.Z) uncompress $1 ;;
    *.7z) 7z x $1 ;;
    *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#   -------------------------------
#   4.  NETWORKING
#   -------------------------------

alias ipInfo0='ifconfig en0' # ipInfo0: Get info on connections for en0
alias ipInfo1='ifconfig en1' # ipInfo1: Get info on connections for en1
alias header='curl -I'

function myip() {
  echo "🖥️  Local IP (v4):\t$(ifconfig en0 | grep 'inet ' | awk '{print $2}')"
  echo "🖥️  Local IP (v6):\t$(ifconfig en0 | grep inet6 | awk '{print $2}')"
  echo "🌍 Public IP:\t\t$(curl -s http://ipecho.net/plain)"
}

function listenon() {
  readonly port=${1:?"The port must be specified."}
  lsof -nP -iTCP:$1 | grep LISTEN
}

function killport() {
  readonly port=${1:?"The port must be specified."}
  pids=$(lsof -i tcp:"$port" | grep LISTEN | awk '{print $1,$2}')

  if [ ${#pids[@]} -eq 0 ]; then
    echo "No process on port $port found!"
  else
    for i in "${pids[@]}"; do
      pid=$(echo "$i" | awk '{print $2}')
      name=$(echo "$i" | awk '{print $1}')
      $(kill -9 $pid)
      echo "-> Killed $name ($pid)"
    done
  fi
}

#   -------------------------------
#   5.  OTHER
#   -------------------------------

alias weather='curl v2.wttr.in' # Get weather from v2.wttr.in
if [ -x "$(command -v terminal-notifier)" ]; then
  alias notifyDone='terminal-notifier -title "Terminal" -subtitle "Done with task!" -sound default -message "Exit status: $?" -activate com.googlecode.iterm2'
fi

function ii() {
  echo -e "\nYou are logged on ${RED}$HOST"
  echo -e "\nAdditional information:$NC "
  uname -a
  echo -e "\n${RED}Users logged on:$NC "
  w -h
  echo -e "\n${RED}Current date :$NC "
  date
  echo -e "\n${RED}Machine stats :$NC "
  uptime
  echo -e "\n${RED}Current network location :$NC "
  scselect
  echo -e "\n${RED}Public facing IP Address :$NC "
  myip
  echo
}

#   -------------------------------
#   99.  PERSONAL
#   -------------------------------
alias python="python3"
alias cl="clear"
alias d="docker"
alias afk="osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down,control down}'"
alias vsc='code .'
alias vim='nvim'
alias hidefile="defaults write com.apple.Finder AppleShowAllFiles false && killall Finder"
alias showhidefile="defaults write com.apple.Finder AppleShowAllFiles true && killall Finder"
alias v='nvim'
alias vi='nvim'
alias vc='nvim $(fzf)'
