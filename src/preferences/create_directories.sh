
cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../util/utils.sh"

create_directories() {
    declare -a DIRECTORIES=(
        "$HOME/git"
        "$HOME/projects"
        "$HOME/Downloads/torrents"
    )

    for i in "${DIRECTORIES[@]}"; do
        mkd "$i"
    done
}

main() {
    print_in_purple "\n • Creating directories\n\n"
    create_directories
}

main