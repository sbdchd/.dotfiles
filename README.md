# Dotfiles

A collection of dotfiles, currently for osx.


## Install
```bash
git clone https://github.com/sbdchd/.dotfiles
cd .dotfiles
. dotfiles-link.sh
```

### Update
```bash
git pull
```

## Install Programs

OSX

```bash
. osx-install.sh 
```

Linux

```bash
sudo bash linux-install.sh
```

*Note:* For a limited install with linux call `linux-install.sh` with the `-small`flag

## Update Programs

OSX

```bash
. osx-update.sh
```

Linux

```bash
sudo bash linux-update.sh
```

## Notes

Git username and email must be set

```bash
git config --global user.name
git config --global user.email
```

# To Do

- [ ] Add a unified script to install & update dotfiles
- [x] Add script to system link dotfiles
- [ ] Add option for basic program install & full program install
