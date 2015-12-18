#!/usr/bin/env zsh

#autoenv_cd() {
#    if [ "${PWD##$CURRENT_VENV_ROOT}" != "$PWD" ]; then
#        deactivate_venv "$CURRENT_VENV_ROOT"
#    fi
#
#    if builtin cd "$@" then
#        if within_current_venv_root() then
#            return 0
#        else
#            if within_venv() then
#                activate_venv("$PWD")
#        return 0
#    else
#        return $?
#    fi
#}

#toogle_venv() {
#
#}


autovenv_cd() {
    local to_path from_path
    to_path = $1
    from_path=`PWD`

}


where_are_we_going() {
    local from_path to_path
    from_path=$1
    to_path=$2

    if [[ $from_path = $to_path ]]; then
        echo "nowhere"
    else
        if [[ $from_path = "$to_path"* ]]; then
            echo "up"
        else
            echo "down"
        fi
    fi
    return 0
}
#path_starts_with_another_path() {
#
#    path1=$1
#    path2=$2
#
#    if [[ $path1 == "$path2"* ]]; then
#        echo "yes"
#    else
#        echo "no"
#    fi
#}

#cd() {
    #autoenv_cd "$@"
#}

activate_venv() {
    #$1/*/bin/activate
    current_venv_root = $1
    echo "activating venv at $1"
}

deactivate_venv() {
    #$1/*/bin/deactivate
    current_venv_root = ""
    echo "deactivating venv at $1"
}
