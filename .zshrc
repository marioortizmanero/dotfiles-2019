# ---- CONFIG ----
HIST_STAMPS="dd/mm/yyyy"
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# ---- PLUGINS & THEMES ----
# ZSH Syntax Hyghlighting:
source $HOME/Documents/Programs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Pure:
autoload -Uz promptinit
promptinit
prompt pure

# ---- PATH ----
PATH=$PATH:~/.local/bin

# ---- ALIAS ----
# Configuration files
alias vim="nvim"
alias zshconf="vim ~/.zshrc"
alias vimconf="vim ~/.config/nvim/init.vim"
alias xprofileconf="vim ~/.xprofile"
alias polyconf="vim ~/.config/polybar/config"
alias polyinitconf="vim ~/.config/polybar/launch.sh"
alias i3conf="vim ~/.config/i3/config"
alias comptonconf="vim ~/.config/compton.conf"
alias roficonf="vim ~/.config/rofi/arch.rasi"
alias kittyconf="vim ~/.config/kitty/kitty.conf"
alias dunstconf="vim ~/.config/dunst/dunstrc"
alias lightdmconf="sudo nvim /etc/lightdm/lightdm-webkit2-greeter.conf"
alias lightdmwebkitconf="sudo nvim /usr/share/lightdm-webkit/themes"

# Default flags
alias ls="ls -A --color"

# Programs
alias photoshop="WINEPREFIX=~/.wine-prefixes/photoshop64 wine64 ~/Documents/Programs/photoshop_2019/Photoshop.exe"

# Shortcuts
alias nuke="killall -s SIGKILL"
alias quitsession="kill -9 -1"
alias getpid="xprop _NET_WM_PID | cut -d' ' -f3"
alias xampp="sudo /opt/lampp/lampp start"

alias py="python3"
alias pymake="python3 setup.py sdist bdist_wheel"
alias pysetup="python3 ./setup.py install --user --force"
alias pyupload="twine upload dist/*"

alias :q="exit"
alias :wq="exit"

# Tools for pipes
alias toclip="xsel --clipboard -i"
alias fromclip="xsel --clipboard -o"
alias toixio="curl -F 'f:1=<-' ix.io | tee -a ~/.paste_history"
alias to0x0="curl -F file=@- https://0x0.st | tee -a ~/.paste_history"
pasteixio() { echo $(date '+%d/%m/%Y %H:%M') $(fromclip | toixio) | tee -a ~/.paste_history }
paste0x0() { echo $(date '+%d/%m/%Y %H:%M') $(fromclip | to0x0) | tee -a ~/.paste_history }

# Quick youtube download from clipboard
yt2mp3() 
{
  url="$(xsel --clipboard)"
  downloadpath="~/Documents/Downloaded-YT/%(title)s.%(ext)s"
  youtube-dl $url -o $downloadpath -x --audio-format mp3
}
yt2mp4() 
{
  url="$(xsel --clipboard)"
  downloadpath="~/Documents/Downloaded-YT/%(title)s.%(ext)s"
  youtube-dl $url -o $downloadpath
}

# Cleaning utilities
clean()
{
  if [ -z $1 ]; then num=10; else num=$1; fi;
  echo "LAST $num INSTALLED PACKAGES:"
  history 0 | tac | grep -m $num -e " sudo pacman -S " -e " yay -S " -e " pip3 install "
  echo "ORPHAN PACKAGES:"
  yay -Qqtd
  echo "CACHE CLEANING:"
  paccache -v -d
}
moreinfo()
{
  if [ -z $1 ]; then
    echo "Error: No program provided"
    return 1
  else
    color="\e[36m"
    default="\e[39m"
    echo "$color>> whatis:$default"; whatis $@
    echo "$color>> whereis:$default"; whereis $@
    echo "$color>> yay -Qi:$default"; yay -Qi $@
  fi
}

