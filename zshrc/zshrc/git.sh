if ! command -v git 2>&1 /dev/null
then
    exit 1
fi
git config --global core.editor nvim
