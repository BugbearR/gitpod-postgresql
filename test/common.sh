function askYesNo() {
    local ans
    while :
    do
        read -p "$1""(y/n)" ans
        case $ans in
            [Yy]) return 0;;
            [Yy][Ee][Ss]) return 0;;
            [Nn]) return 1;;
            [Nn][Oo]) return 1;;
        esac
    done
}
