export EDITOR=nvim
export TERM=screen-256color
eval "$(starship init bash)"
export STARSHIP_CONFIG=~/.config/starship.toml
export STARSHIP_CACHE=~/.starship/cache
eval "$(zoxide init --cmd cd bash)"
export SSH_AUTH_SOCK=$(ls /tmp/ssh-*/agent.* 2>/dev/null | head -n 1)

# neovim alieas
alias v="nvim"
#
# Tmux
alias tl="tmux ls"
alias ta="tmux attach -t"
#
#git alias
alias gst="git status"
alias glg="git log"
alias gad="git add ."
alias gcl="git clone"
alias lg="lazygit"
#
#open alias
alias open="xdg-open"

#superfile alias
alias spf="superfile"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# golang and nix os shit
export PATH="$HOME/go/bin:$PATH"

# ssh agent
# Only start agent if it's not already running
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/github_id_ed25519
fi

# pnpm
export PNPM_HOME="/home/neo/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
