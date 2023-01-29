set fish_greeting ""
set PATH ~/.local/bin $PATH
set VIRTUALFISH_HOME ~/projects

# Abbreviations
abbr ls "exa -1 -la --group-directories-first"
abbr p "sudo pacman"
abbr P "paru"

# Prompt
starship init fish | source
