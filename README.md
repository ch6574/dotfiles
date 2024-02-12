# Synopsis
Dotfiles for home directory.

See https://www.atlassian.com/git/tutorials/dotfiles for details.

# Installing
```bash
dotfiles() {
    git "--git-dir=${HOME}/.dotfiles" "--work-tree=${HOME}" "${@}"
}

dotfiles init
dotfiles config --local status.showUntrackedFiles no
dotfiles remote add origin "git@github.com:ch6574/dotfiles.git"
dotfiles fetch
dotfiles checkout origin/master -ft
```

# Using
Substitute `dotfiles` for regular `git` commands:
```bash
# Pulling updates
dotfiles branch -r
dotfiles fetch
dotfiles diff origin/master
dotfiles pull --rebase

# Checking what local files are tracked
dotfiles ls-files

# Adding / pushing
dotfiles add .foo
dotfiles status
dotfiles commit -am "added .foo"
dotfiles push

# Pulling specific file
dotfiles checkout .foo
```

# License
GPL v3
