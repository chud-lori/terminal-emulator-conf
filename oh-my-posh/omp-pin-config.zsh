# Pin the oh-my-posh theme config on every prompt render.
#
# oh-my-posh v28 resolves --config once at init and caches the result per
# session in ~/.cache/oh-my-posh/zsh.<POSH_SESSION_ID>.omp.cache. The precmd
# render (`print primary`) passes no --config, so once that cache entry
# expires or is clobbered mid-session every render silently falls back to
# omp's built-in default theme (yellow user / orange dir / blue status bar
# plus an "in zsh at HH:MM:SS" rprompt) until the shell is re-exec'd.
# Injecting --config here makes resolution independent of the session cache.
#
# Source this AFTER the `oh-my-posh init zsh` eval in ~/.zshrc.

# Requires the omp init script to have run in this shell.
(( $+functions[_omp_get_prompt] )) || return 0
# Idempotent: skip if a pin is already installed.
[[ ${functions[_omp_get_prompt]} == *--config=* ]] && return 0

functions[_omp_get_prompt_orig]=${functions[_omp_get_prompt]}
_omp_get_prompt() {
  local type=$1
  shift
  _omp_get_prompt_orig "$type" --config="$HOME/.config/oh-my-posh/theme.omp.json" "$@"
}
