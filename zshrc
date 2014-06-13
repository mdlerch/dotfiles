# Colors
autoload -U colors
colors

setopt rmstarsilent
setopt prompt_subst

# Prompt

autoload -Uz vcs_info

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{3} ...'
zstyle ':vcs_info:*' unstagedstr '%F{9} +++'
zstyle ':vcs_info:*' enable git svn
precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats ' [%F{10}%b%c%u%%F{7}]'
    } else {
        zstyle ':vcs_info:*' formats ' [%F{10}%b%F{6} !!!%c%u%F{7}]'
    }
    vcs_info
}

local smiley="%(?,%{$fg_bold[green]%}:%)%{$reset_color%},%{$fg_bold[red]%}:(%{$reset_color%})"

PROMPT='[%(#~%{$fg_bold[red]%}>root< %{$reset_color%}~)%{$fg_bold[green]%}%m%{$reset_color%}] %{$fg_bold[yellow]%}> %{$reset_color%}%~${vcs_info_msg_0_}
${smiley} '

export HISTSIZE=2000
export HISTFILE="$HOME/.zsh_history"

export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
autoload compinit
compinit

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char

source ~/.zsh/alias.zsh
source /usr/bin/virtualenvwrapper.sh

stty stop undef
