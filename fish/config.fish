set fish_greeting ""
set PATH ~/.local/bin $PATH
set VIRTUALFISH_HOME ~/projects

# Abbreviations
abbr ls "exa -1 -la --group-directories-first"

# Prompt
function fish_prompt
    set -l last_status $status
    set -l cwd (string replace $HOME "~" $(pwd))

    # Working directory
    echo -n -s (set_color --bold magenta) $cwd
    echo -n -s (set_color normal) " "

    # Git status
    set -l git_branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
    set -l git_dirty (command git status -s --ignore-submodules=dirty 2> /dev/null)
    if test -n "$git_branch"
        if test -n "$git_dirty"
            echo -n -s (set_color white) "on " (set_color --bold yellow) "$git_branch"
        else
            echo -n -s (set_color white) "on " (set_color --bold green) "$git_branch"
        end
        echo -n -s (set_color normal) " "
    end

    # Virtual environment
    if set -q VIRTUAL_ENV
        echo -n -s (set_color white) "in " (set_color --bold blue) (basename "$VIRTUAL_ENV")
        echo -n -s (set_color normal) " "
    end

    # Error code
    if not test $last_status -eq 0
        echo -n -s (set_color --bold red) $last_status
        echo -n -s (set_color normal) " "
    end

    # Super user indicator
    if [ $USER = "root" ]
        echo -n -s (set_color --bold white) "#"
        echo -n -s (set_color normal) " "
    end
end
