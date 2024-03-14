#!/bin/bash

# simple function for errors
error(){
  echo "Try './lab1 -h' for help."
  exit 1
}

# first parameter must exist
if [ -n "$1" ]; then

# when run with flag -h
  if [ "$1" == '-h' ]; then
    echo -e "\nThis program will generate some random passwords"
    echo "for your file with logins, split by spaces or enters."
    echo "You will find results in results.csv."

    echo -e "\n\1) nThe length of passwords must be specified"
    echo "as a first parameter and be a number."

    echo "2) An input file must exist."

    echo -e "\n\n     WARNING"
    echo "results.csv will be overwritten while each program's execution,"
    echo "make sure you have saved it before next run."
    exit 0
  fi

# password's length must be a number
  reg='^[0-9]+$'
  if ! [[ $1 =~ $reg ]]; then
    echo "ERROR: First parameter must be a number."
    error
  fi

# password's length is specified as a first parameter
  length=$1

# input path to file with logins
  echo "Enter path to input file:"
  read -r inputPath

# check if input is an existing file
  if [ -f "$inputPath" ]; then

# new file for results is created. If there's one, it would be overwritten
    results="results.csv"
    touch $results
    echo "" > $results

# pwgen is installed/updated
    echo "PwGen will be installed. Please, enter your password."
    sudo apt install pwgen

# for each line in the input file a password is generated and a pair login, password is written into results.csv
    for login in $(cat "$inputPath"); do
      password=$(pwgen -1 -s -n "$length")
      echo "$login,$password" >> "$results"
    done

  else
    echo "ERROR: Incorrect path."
    error
  fi

else
  echo "ERROR: Please, specify the first parameter."
  error
fi