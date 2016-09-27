chpwd() {
    unsetopt nomatch 2>/dev/null
    local search_path v
    search_path=$(pwd)
    local common_home=$(dirname $HOME)
    while [[ $search_path != $common_home && $search_path != '' ]]; do
        v=$(for d in $search_path/.*/ $search_path/*/; do echo $d; done | xargs -I {} $SHELL -c '[ -e {}bin/activate ] && echo "{}bin/activate"') 2>/dev/null;
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
