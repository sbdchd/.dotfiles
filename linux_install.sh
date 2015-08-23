#1 /bin/sh

apt-get install curl
apt-get install wget
apt-get install git
apt-get install vim
apt-get install unp
apt-get install htop
apt-get install tmux

apt-get install virtualbox
apt-get install vagrant

wget -qO- https://get.docker.com/ | sh
wget https://raw.github.com/progrium/dokku/v0.3.25/bootstrap.sh
DOKKU_TAG=v0.3.25 bash bootstrap.sh


apt-get install openssh-server
apt-get install fail2ban

add-apt-repository ppa:transmissionbt/ppa
apt-get update
apt-get install transmission-cli transmission-common transmission-daemon

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

apt-get install golang
apt-get install python python3 python-dev python-pip python3-dev python3-pip

add-apt-repository ppa:neovim-ppa/unstable
apt-get update
apt-get install neovim


