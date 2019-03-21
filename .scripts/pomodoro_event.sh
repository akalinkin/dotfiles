#!/bin/sh

DB="/home/alex/.pomodoro/worklog.db"

# Define a timestamp function
timestamp() {
  date +"%Y-%m-%dT%H:%M:%SZ+03"
}

printf '%s\n' `timestamp` $1 $2 | paste -sd ',' >> $DB

unset timestamp;
