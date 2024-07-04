CONFIGS=$HOME/zshrc
FILES_STR=$(fd --glob '*.sh' --exclude 'init.sh' $CONFIGS)
FILES=($(echo $FILES_STR | tr '\n' ' '))
for FILE in $FILES; do
    source $FILE
done
