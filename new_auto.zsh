find_venv_above() {
#    unsetopt nomatch 2>/dev/null
    local search_path v
    search_path=${1:-$HOME}
    builtin cd $search_path
    search_path=$(pwd)
    while [[ ${search_path} = /*/* ]]; do
        #echo "$search_path"
        v=$(find $search_path -maxdepth 3 -mindepth 3 -path "*/bin/activate")
        [[ $v != "" ]] && {
          #printf '%s\n' "$search_path"
          . $v
          return 0
        }
        search_path=${search_path%/*}
    done
    deactivate
}

alias cd=find_venv_above
echo 'lalall'
