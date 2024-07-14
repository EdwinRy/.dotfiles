
if ! command -v gh 2>&1 /dev/null
then
    exit 1
fi
gh config set editor "nvim"
