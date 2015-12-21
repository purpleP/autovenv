#!/usr/bin/env bash

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


#autovenv_cd() {
#    local to_path from_path going_to
#    to_path=$1
#    from_path=`PWD`
#    going_to=$(where_are_we_going)
#    if going_to=down; then
#        if find_venv_above to_path then
#            activate_venv
#        fi
#    if goint_to='up'; then
#        if find_venv_above then
#            active_venv
#        else
#            deactivate_venv
#    fi


#}

#expandPath() {
#  local path
#  local -a pathElements resultPathElements
#  IFS=':' read -r -a pathElements <<<"$1"
#  : "${pathElements[@]}"
#  for path in "${pathElements[@]}"; do
#    : "$path"
#    case $path in
#      "~+"/*)
#        path=$PWD/${path#"~+/"}
#        ;;
#      "~-"/*)
#        path=$OLDPWD/${path#"~-/"}
#        ;;
#      "~"/*)
#        path=$HOME/${path#"~/"}
#        ;;
#      "~"*)
#        username=${path%%/*}
#        username=${username#"~"}
#        IFS=: read _ _ _ _ _ homedir _ < <(getent passwd "$username")
#        if [[ $path = */* ]]; then
#          path=${homedir}/${path#*/}
#        else
#          path=$homedir
#        fi
#        ;;
#    esac
#    resultPathElements+=( "$path" )
#  done
#  local result
#  printf -v result '%s:' "${resultPathElements[@]}"
#  printf '%s\n' "${result%:}"
#}

find_venv_above() {
#    unsetopt nomatch 2>/dev/null
    local search_path v
    search_path=${1:-$HOME}
    builtin cd $search_path
    search_path=$(pwd)
    while [[ ${search_path} = /*/* ]]; do
        echo "$search_path"
        v=$(find $search_path -maxdepth 3 -mindepth 3 -path "*/bin/activate")
        [[ $v != "" ]] && {
          printf '%s\n' "$search_path"
          . $v
          return 0
        }
        search_path=${search_path%/*}
    done
    deactivate
}

#find_venv() {
#    local dir=${1:-$1}
#    for option in ${dir}/*/bin/activate; do
#        [[ -x "$option" ]] && {
#          printf '%s\n' "${option%/bin/activate}"
#          return 0
#        }
#    done
#    return 1
#}
#
#
#pring() {
#    local search_path=`PWD`
#    if venv_root=$(find_venv_above search_path}); then
#        echo "Currently in a virtualenv rooted at $venv_root"
#    else
#        echo "no venv found"
#    fi
#
#}
#

#has_venv_in_path() {
#    unsetopt nomatch 2>/dev/null
#    local path_to_search p
#    p=$1
#    path_to_search=$(expandPath "$p")
#    echo "searching in $path_to_search"
#    if [[ ${path_to_search} = "/" ]]; then
#        echo "no"
#    fi
#
#    ls ${path_to_search}/*/bin/activate > /dev/null 2> /dev/null
#    if [ "$?" = '0' ]; then
#        echo "yes"
#    else
#        has_venv_in_path $(dirname "$path_to_search")
#    fi
#}

#where_are_we_going() {
#    local from_path to_path
#    from_path=$1
#    to_path=$2
#
#    if [[ ${from_path} = ${to_path} ]]; then
#        echo "nowhere"
#    else
#        if [[ ${from_path} = "$to_path"* ]]; then
#            echo "up"
#        else
#            echo "down"
#        fi
#    fi
#    return 0
#}
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

#
#activate_venv_test() {
#    #$1/*/bin/activate
#    current_venv_root = $1
#    echo "activating venv at $1"
#}
#
#deactivate_venv_test() {
#    #$1/*/bin/deactivate
#    current_venv_root = ""
#    echo "deactivating venv at $1"
#}
