find_venv() { unsetopt nomatch 2>/dev/null
    local search_path venv_dir
    search_path=$(pwd)
    local common_home=$(dirname $HOME)
    while [[ $search_path != $common_home && $search_path != '' ]]; do
        venv_dir=$(find -maxdepth 1 -type d -exec test -e "{}/bin/activate" \; -print -quit);
        [[ $venv_dir != "" ]] && . $venv_dir/bin/activate && return 0
        search_path=${search_path%/*}
    done
    deactivate 2>/dev/null
    return 0
}

has_python_packages() {
    local package=$(find $(pwd) -maxdepth 1 -type d -exec test -e "{}/__init__.py" \; -print -quit)
    if [[ -n $package && ":$PYTHONPATH:" != *":$(pwd):"* ]]; then
        export PYTHONPATH=$PYTHONPATH:$(pwd)
    fi
    return 0
}
chpwd_functions=(${chpwd_functions[@]} "has_python_packages")
chpwd_functions=(${chpwd_functions[@]} "find_venv")
