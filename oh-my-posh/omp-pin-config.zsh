# Pin the oh-my-posh theme config on every prompt render, and keep it pinned.
#
# oh-my-posh v28 resolves --config once at init and caches the result per
# session. Renders (`print primary`/`transient`) pass no --config, so when that
# cache expires or oh-my-posh re-inits (a reload redefines _omp_get_prompt
# without the pin), rendering silently falls back to the built-in default theme
# until the shell is re-exec'd. Injecting --config on every render makes the
# theme independent of the cache; re-applying the pin each precmd makes it
# survive a re-init (which is what used to require `exec zsh`).
#
# Source this AFTER the `oh-my-posh init zsh` eval in ~/.zshrc.

_omp_pin_config() {
  (( $+functions[_omp_get_prompt] )) || return 0
  # Already pinned: nothing to do.
  [[ ${functions[_omp_get_prompt]} == *--config=* ]] && return 0
  functions[_omp_get_prompt_orig]=${functions[_omp_get_prompt]}
  _omp_get_prompt() {
    local type=$1
    shift
    _omp_get_prompt_orig "$type" --config="$HOME/.config/oh-my-posh/theme.omp.json" "$@"
  }
}

_omp_pin_config

# Re-pin before every prompt, so a reload that redefines _omp_get_prompt cannot
# leave the default theme showing. Runs before oh-my-posh's own precmd render.
autoload -Uz add-zsh-hook
add-zsh-hook precmd _omp_pin_config
precmd_functions=(_omp_pin_config ${precmd_functions:#_omp_pin_config})
