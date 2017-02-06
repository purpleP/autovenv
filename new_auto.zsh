activate_venv() {
    unsetopt nomatch 2>/dev/null
    local venv=$(find_venv)
    if [[ -n $venv ]]; then
        . $venv/bin/activate
    else
        deactivate 2>/dev/null
    fi
    return 0
}

find_venv() {
    local project_root=$(git rev-parse --show-toplevel 2>/dev/null)
    if [[ -n $project_root ]]; then
        venv_dir=$(find -maxdepth 1 -type d -exec test -e "{}/bin/activate" \; -print -quit)
        [[ -n $venv_dir ]]; echo $venv_dir; return 0
    fi
    local search_path venv_dir
    search_path=$(pwd)
    local common_home=$(dirname $HOME)
    while [[ $search_path != $common_home && $search_path != '' ]]; do
        venv_dir=$(find -maxdepth 1 -type d -exec test -e "{}/bin/activate" \; -print -quit);
        [[ -n $venv_dir ]]; echo $venv_dir; return 0
        search_path=$(dirname $search_path)
    done
    return 0
}

has_python_packages() {
    local search_path=$(pwd)
    if ! [[ -e $(pwd)/__init__.py ]]; then
        local package=$(find $(pwd) -maxdepth 1 -type d -exec test -e "{}/__init__.py" \; -print -quit)
        if [[ -n $package && ":$PYTHONPATH:" != *":$(pwd):"* ]]; then
            for p in ${PYTHONPATH//:/ }; do
                [[ $PWD/ = $p ]]; return 0
            done
            export PYTHONPATH=$PYTHONPATH:$(pwd)
        fi
    fi
    return 0
}
chpwd_functions=(${chpwd_functions[@]} "has_python_packages")
chpwd_functions=(${chpwd_functions[@]} "activate_venv")
