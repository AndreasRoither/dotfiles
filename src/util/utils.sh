#!/bin/bash

ask_for_sudo() {

    # Ask for the administrator password upfront.

    sudo -v &>/dev/null

    # Update existing `sudo` time stamp
    # until this script has finished.
    #
    # https://gist.github.com/cowboy/3118588

    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done &>/dev/null &
}

get_answer() {
    printf "%s" "$REPLY"
}

cmd_exists() {
    command -v "$1" &>/dev/null
}

is_git_repository() {
    git rev-parse &>/dev/null
}

skip_questions() {
    while :; do
        case $1 in
        -y | --yes) return 0 ;;
        *) break ;;
        esac
        shift 1
    done

    return 1
}

kill_all_subprocesses() {
    local i=""

    for i in $(jobs -p); do
        kill "$i"
        wait "$i" &>/dev/null
    done
}

set_trap() {
    trap -p "$1" | grep "$2" &>/dev/null ||
        trap '$2' "$1"
}

execute() {

    local -r CMDS="$1"
    local -r MSG="${2:-$1}"
    local -r TMP_FILE="$(mktemp /tmp/XXXXX)"

    local exitCode=0
    local cmdsPID=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If the current process is ended,
    # also end all its subprocesses.

    set_trap "EXIT" "kill_all_subprocesses"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Execute commands in background
    # shellcheck disable=SC2261

    eval "$CMDS" \
        &>/dev/null \
        2>"$TMP_FILE" &

    cmdsPID=$!

    # Wait for the commands to no longer be executing
    # in the background, and then get their exit code.

    wait "$cmdsPID" &>/dev/null
    exitCode=$?

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Print output based on what happened.

    if [ $exitCode -ne 0 ]; then
        print_error_stream <"$TMP_FILE"
    fi
    rm -rf "$TMP_FILE"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    return $exitCode
}

mkd() {
    if [ -n "$1" ]; then
        if [ -e "$1" ]; then
            if [ ! -d "$1" ]; then
                print_error "$1 - a file with the same name already exists!"
            else
                print_success "$1"
            fi
        else
            execute "mkdir -p $1" "$1"
        fi
    fi
}

print_result() {

    if [ "$1" -eq 0 ]; then
        print_success "$2"
    else
        print_error "$2"
    fi

    return "$1"
}

print_success() {
    print_in_green " [✔] $1\n"
}

print_warning() {
    print_in_yellow " [!] $1\n"
}

print_error() {
    print_in_red " [✖] $1 $2\n"
}

print_error_stream() {
    while read -r line; do
        print_error "↳ ERROR: $line"
    done
}

print_in_color() {
    printf "%b" \
        "$(tput setaf "$2" 2>/dev/null)" \
        "$1" \
        "$(tput sgr0 2>/dev/null)"
}

print_in_green() {
    print_in_color "$1" 2
}

print_in_purple() {
    print_in_color "$1" 5
}

print_in_red() {
    print_in_color "$1" 1
}

print_in_yellow() {
    print_in_color "$1" 3
}

print_in_blue() {
    print_in_color "$1" 12
}

print_question() {
    print_in_yellow " [?] $1"
}
