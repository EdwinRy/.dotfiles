if ! command -v gh > /dev/null 2>&1
then
    return
fi
gh config set editor "nvim"
