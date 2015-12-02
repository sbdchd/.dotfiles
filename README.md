# Dotfiles

A collection of dotfiles, currently for osx.


## Install
```bash
git clone https://github.com/sbdchd/.dotfiles
cd .dotfiles
bash dotfiles-link.sh
```

### Update
```bash
git pull
```

## Install Programs

OSX

```bash
bash osx-install.sh 
```

Linux

```bash
sudo bash linux-install.sh
```

*Note:* For a limited install with linux call `linux-install.sh` with the `-small`flag

## Update Programs

OSX

```bash
bash osx-update.sh
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
