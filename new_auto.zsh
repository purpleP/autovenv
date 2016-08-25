find_venv_above() {
    unsetopt nomatch 2>/dev/null
    local search_path v
    search_path=${1:-$HOME}
    builtin cd $search_path
    search_path=$(pwd)
    while [[ ${search_path} = /*/* ]]; do
        v=$(for d in $search_path/.*/ $search_path/*/; do echo $d; done | xargs -I {} $SHELL -c '[ -e {}bin/activate ] && echo "{}bin/activate"');
        [[ $v != "" ]] && {
          v=$(echo $v | head -n 1)
          . $v
          return 0
        }
        search_path=${search_path%/*}
    done
    deactivate 2>/dev/null
    return 0
}

alias cd=find_venv_above
