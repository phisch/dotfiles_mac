if [[ $- == *i* ]] && command -v nu >/dev/null 2>&1; then
    exec nu
fi
