#
# Defines tmux aliases and provides for auto launching it at start-up.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Colin Hebert <hebert.colin@gmail.com>
#   Georges Discry <georges@discry.be>
#   Xavier Cambar <xcambar@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[tmux] )); then
  return 1
fi

#
# Auto Start
#

if ([[ "$TERM_PROGRAM" = 'iTerm.app' ]] && \
  zstyle -t ':prezto:module:tmux:iterm' integrate \
); then
  _tmux_iterm_integration='-CC'
fi

if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" ]] && ( \
  ( [[ -n "$SSH_TTY" ]] && zstyle -t ':prezto:module:tmux:auto-start' remote ) ||
  ( [[ -z "$SSH_TTY" ]] && zstyle -t ':prezto:module:tmux:auto-start' local ) \
); then
  tmux start-server

  # Create a 'prezto' session if no session has been defined in tmux.conf.
  if ! tmux has-session 2> /dev/null; then
    zstyle -s ':prezto:module:tmux:session' name tmux_session || tmux_session='prezto'
    tmux \
      new-session -d -s "$tmux_session" \; \
      set-option -t "$tmux_session" destroy-unattached off &> /dev/null
  fi

  # Attach to the 'prezto' session or to the last session used. (detach first)
  exec tmux $_tmux_iterm_integration attach-session -d
fi


tmuxa() {
  command tmux $_tmux_iterm_integration new-session -D -A -s "$1"
}
compdef -e 'words[1]=(tmux attach -t); service=tmux; (( CURRENT+=2 )); _tmux' tmuxa


#
# Aliases
#

alias tmuxn='tmux $_tmux_iterm_integration new-session -s'
alias tmuxl='tmux list-sessions'
