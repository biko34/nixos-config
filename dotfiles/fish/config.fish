if status is-interactive
    # Commands to run in interactive sessions can go here
end
alias ls='eza -la --color=always --icons'
alias nrs="cd ~/nixos-config && git add . && sudo nixos-rebuild switch --flake .#default"
alias netejar5="sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5"
alias nupdate="cd ~/nixos-config && nix flake update && nrs"
starship init fish | source
set -U fish_greeting 
nitch