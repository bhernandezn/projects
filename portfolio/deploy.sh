#!/bin/bash

# Check if an argument was provided
if [ $# -eq 0 ]; then
    echo "Error: Docker Compose file name is required"
    echo "Usage: ./deploy.sh <filename>"
    exit 1
fi

# Show realtime logs
echo "show logs realtime"
scp -i ~/git/pems/services.pem ./$1 ubuntu@xxxx:~/$1
ssh -i ~/git/pems/services.pem ubuntu@xxxx "cd ~/ && docker compose -f $1 up -d 2>&1"
ssh -i ~/git/pems/services.pem ubuntu@xxxx "cd ~/ && rm $1 2>&1"