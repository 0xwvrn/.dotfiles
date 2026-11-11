#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Pywal terminal sequences & fzf theme
if [ -f ~/.cache/wal/sequences ]; then
    (cat ~/.cache/wal/sequences &)
fi
if [ -f ~/.cache/wal/colors-fzf.sh ]; then
    source ~/.cache/wal/colors-fzf.sh
fi

# Modern blocky nmtui / newt dark high-contrast theme
export NEWT_COLORS="root=white,black:border=lightgray,black:window=white,black:shadow=black,black:title=brightcyan,black:button=white,black:actbutton=black,brightcyan:compactbutton=white,black:checkbox=white,black:actcheckbox=black,brightcyan:entry=brightwhite,gray:label=white,black:listbox=white,black:actlistbox=white,black:sellistbox=white,gray:actsellistbox=black,brightcyan:textbox=white,black:acttextbox=black,brightcyan:helpline=lightgray,black:roottext=lightgray,black:emptyscale=gray,black:fullscale=brightcyan,black:disentry=gray,black"
alias nmtui="LD_PRELOAD=/home/wvrn/.local/lib/libnmtui_pretty.so /usr/bin/nmtui"
alias nmtui-connect="LD_PRELOAD=/home/wvrn/.local/lib/libnmtui_pretty.so /usr/bin/nmtui-connect"
alias nmtui-edit="LD_PRELOAD=/home/wvrn/.local/lib/libnmtui_pretty.so /usr/bin/nmtui-edit"
alias nmtui-hostname="LD_PRELOAD=/home/wvrn/.local/lib/libnmtui_pretty.so /usr/bin/nmtui-hostname"

