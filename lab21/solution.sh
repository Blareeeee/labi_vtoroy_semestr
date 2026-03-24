#!/bin/bash

usage() {
    cat <<EOF
Usage: $0 [OPTION]... DIRECTORY
Recursively replace backslashes with forward slashes in files named Makefile* within DIRECTORY.

  -h, --help    display this help and exit
EOF
}

# Проверка флага помощи
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
    exit 0
fi

# Должен быть ровно один аргумент
if [[ $# -ne 1 ]]; then
    echo "Error: invalid number of arguments." >&2
    exit 1
fi

dir="$1"

# Проверка существования каталога
if [[ ! -d "$dir" ]]; then
    echo "Error: $dir is not a valid directory." >&2
    exit 1
fi

# Поиск файлов
find "$dir" -type f -name 'Makefile*' -exec sed -i 's/\\/\//g' {} \;

# Проверка кода завершения
if [[ $? -ne 0 ]]; then
    echo "Error during processing." >&2
    exit 1
fi

exit 0
