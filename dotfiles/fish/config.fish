set -g fish_greeting ""
oh-my-posh init fish --config /usr/share/oh-my-posh/themes/1_shell.omp.json | source
if status is-interactive
# Commands to run in interactive sessions can go here
end
