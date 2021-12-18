function backup_and_create {
    if [ $# != 2 ]; then
        echo "backup and create needs 2 inputs"
        return
    fi

    echo "Checking if $2 exists"

    if [ ! -f $1 ]; then 
      echo "$1 does not exist, cannot backup and create link"
      return
    fi

    if [ -f $2 ]; then
      echo "$2 already exists, backing up to $2.${TIMESTAMP}"
      mv "$2" "$2.${TIMESTAMP}"
    fi

    ln -s $1 $2
}
