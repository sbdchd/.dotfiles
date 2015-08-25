# Dotfiles

A collection of dotfiles, currently for osx.


##Notes

User interaction is initially required with osx_install.sh

`sudo ./osx_install.sh`

Git username and email must be set

```bash
git config --global user.name
git config --global user.email
```

#To Do

- [ ] Add script to install/update dotfiles
- [ ] Add script to system link dotfiles
- [ ] Adjust tmux activation in .bashrc so that only with a full terminal session is tmux enabled. This would prevent tmux attempting to activate when sending just a command over ssh
