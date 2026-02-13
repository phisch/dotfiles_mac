export GPG_TTY="$(tty)"

if [ -n "$SSH_CONNECTION" ]; then
    export SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.extra-ssh
else
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

if [[ $- == *i* ]] && command -v nu >/dev/null 2>&1; then
    exec nu
fi
