#! /bin/bash

PARAMS="./params"
POSTES="./postes"

FILE_TO_SAVE=./FILE_TO_SAVE
REP_ORIGINAL=./ORIGINAL_FILES/

function save_files() {
  for file in `cat $FILE_TO_SAVE`
  do
    if test -e ${REP_ORIGINAL}/`basename $file` 
    then
      echo "$file est déjà sauvegardé"
    else
      cp -a $file ${REP_ORIGINAL}  #-a garde les permissions initiales
    fi
  done  
}

function restore_files() {
  for file in `cat $FILE_TO_SAVE`
  do
     cp -a ${REP_ORIGINAL}/`basename $file` $file
  done  
}


# utilisation de fonction if test `exist /etc/hosts server` == "0" ; then
function exist() { # utilisation exist <path> [word] ex: exist /etc/hosts "saveur"
  if grep -q "$2" "$1" #-q quiet
  then
    echo "0"
  else
    echo "1"
  fi
}

# replace_line /etc/passwd "niko" "toto:1024:20"
function replace_line() {
  cp -f $1 $1.old 
  if sed "\!$2! c $3" $1 > $1.new
  then
    mv -f $1.new $1
    echo "0"
  else
    echo "1"
  fi
}

function remove_line() {
  cp -f $1 $1.old 
  if sed "\!$2! d $3" $1 > $1.new
  then
    mv -f $1.new $1
    echo "0"
  else
    echo "1"
  fi
}

function add_line() {
  echo "$2" >> $1
  echo "0"
}
