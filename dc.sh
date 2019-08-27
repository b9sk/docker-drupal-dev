#!/bin/bash
function dce () {
  if [[ -z $1 ]]; then
    echo "You have to specify a service name as first argument";
    #exit 1;
  fi

  if [[ -z $2 ]]; then
    echo "You have to pass a command using quotes";
    #exit 1;
  fi

  if [[ ! -z $1 ]] && [[ ! -z $2 ]]; then
    docker-compose exec $1 bash -c "$2";
  fi
}

"$@";
