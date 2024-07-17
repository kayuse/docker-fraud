#!/bin/bash

# Function to start OrientDB
start_orientdb() {
  echo "Starting OrientDB..."
  nohup ./home/ubuntu/orientdb-community-3.2.31/bin/server.sh > orientdb.log 2>&1 &
  echo $! > orientdb_pid.txt
  echo "OrientDB started with PID $(cat orientdb_pid.txt)"
}

# Function to check if OrientDB is running
check_orientdb() {
  if [ -f orientdb_pid.txt ]; then
    PID=$(cat orientdb_pid.txt)
    if ps -p $PID > /dev/null; then
      return 0
    else
      return 1
    fi
  else
    return 1
  fi
}

# Main loop to keep OrientDB running
while true; do
  if check_orientdb; then
    echo "OrientDB is running with PID $(cat orientdb_pid.txt)"
  else
    echo "OrientDB is not running. Restarting..."
    start_orientdb
  fi
  sleep 60 # Check every 60 seconds
done
