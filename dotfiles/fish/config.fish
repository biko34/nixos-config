if status is-interactive
    # Commands to run in interactive sessions can go here
end
alias ls='eza -la --color=always --icons'
starship init fish | source
set -U fish_greeting 
