#!/usr/bin/env zsh

export session_name=Lab42VimStrings
export session_home_dir=${Lab42VimStrings:-~/.vim/bundle/Lab42VimStrings}

source $Lab42MyZsh/tools/tmux.zsh
function init_new_session {
        new_window vim 'vip git .'
        new_window autoload 'vip lib autoload'

        new_window test './vimtest'

        new_window 'vi test' 'vip spec test'

        new_window etc
}

attach_or_create

