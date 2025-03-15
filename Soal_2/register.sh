#!/bin/bash

DB_FILE="/data/player.csv"

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <email> <username> <password>"
    exit 1
fi

EMAIL="$1"
USERNAME="$2"
PASSWORD="$3"

PASSWORD_HASH=$(echo -n "$PASSWORD" | sha256sum | awk '{print $1}')

mkdir -p /data

if [ ! -f "$DB_FILE" ]; then
    touch "$DB_FILE"
fi

if grep -q "^$EMAIL," "$DB_FILE"; then
    echo "Error: Email is already registered."
    exit 1
fi

echo "$EMAIL,$USERNAME,$PASSWORD_HASH" >> "$DB_FILE"
echo "Registration successful!"
