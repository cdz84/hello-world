_itwebsettings()
{
    local cur prev opts base
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Icedtea-web settings Options
    opts="-help -list -get -info -set -reset -reset -headless -check -verbose"

    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
    return 0
}
complete -F _itwebsettings itweb-settings
