if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
export SSH_AUTH_SOCK="/run/user/1000/ssh-agent"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
