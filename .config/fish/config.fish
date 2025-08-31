status is-interactive; or exit

set -g fish_greeting

set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_STATE_HOME $HOME/.local/state

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

if command -sq nvim
  set -gx EDITOR nvim
  set -gx VISUAL nvim
  set -gx MANPAGER 'nvim +Man!'
end

fish_config prompt choose informative_vcs
