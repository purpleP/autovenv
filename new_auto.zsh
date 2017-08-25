activate_venv() {
    unsetopt nomatch 2>/dev/null
    local venv=$(find_venv)
    if [[ -n $venv ]]; then
        . $venv/bin/activate
    else
        deactivate 2>/dev/null
    fi
}

find_venv() {
    local project_root=$(git rev-parse --show-toplevel 2>/dev/null)
    if [[ -n $project_root ]]; then
        venv_dir=$(find $project_root -maxdepth 1 -type d -exec test -e "{}/bin/activate" \; -print -quit 2>/dev/null)
        if [[ -n $venv_dir ]]; then
            echo $venv_dir
            return 0
        fi
    fi
    local search_in=($PWD)
    while [[ $search_in[-1] != '/' ]]; do
        search_in+=($(dirname $search_in[-1]))
    done
    find $search_in -maxdepth 1 -type d -exec test -e "{}/bin/activate" \; -print -quit 2>/dev/null
}

has_python_packages() {
    local search_path=$(pwd)
    if ! [[ -e $search_path/__init__.py ]]; then
        local package=$(find $search_path -maxdepth 1 -type d -exec test -e "{}/__init__.py" \; -print -quit 2>/dev/null)
        if [[ -n $package && ":$PYTHONPATH:" != *":$search_path:"* ]]; then
            for p in ${PYTHONPATH//:/ }; do
                [[ $search_path/ = $p ]]; return 0
            done
            export PYTHONPATH=$PYTHONPATH:$search_path
        fi
    fi
}
chpwd_functions=(${chpwd_functions[@]} "has_python_packages")
chpwd_functions=(${chpwd_functions[@]} "activate_venv")
