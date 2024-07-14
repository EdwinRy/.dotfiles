if ! command -v git > /dev/null 2>&1
then
    return
fi
git config --global core.editor nvim
