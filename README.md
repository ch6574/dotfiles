# Synopsis
Dotfiles for home directory

# Example (manual)
```bash
git clone https://github.com/ch6574/dotfiles.git
ln -s dotfiles/.bashrc ~/.bashrc
# etc...
```

# Example (using GNU stow)
```bash
git clone https://github.com/ch6574/dotfiles.git
# Adding
stow --dir=dotfiles --target=~/ --ignore='LICENSE|README.md' .

# Deleting
stow --dir=dotfiles --target=~/ --delete .

```

# License
GPL v3
