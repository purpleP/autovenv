activate_env() {
    # ZSH outputs errors for the ls * command if you don't disable the nomatch output
    unsetopt nomatch 2>/dev/null
    
    ls $SEARCHPATH/*/bin/activate > /dev/null 2> /dev/null
    if [ "$?" = '0' ]; then
      deactivate > /dev/null 2> /dev/null
      source $SEARCHPATH/*/bin/activate
      return
    else
      SEARCHPATH=$(dirname "$SEARCHPATH")
      if [ "$SEARCHPATH" = "/" ]; then
        return
      fi
      activate_env
      return $?
    fi
}

autoenv_cd() {


if builtin cd "$@"
then activate_env
return 0
else return $?
fi
}


cd() {
autoenv_cd "$@"
}
