#! /bin/sh

apt-get update
apt-get upgrade

apt-get install -y curl
apt-get install -y wget
apt-get install -y git
apt-get install -y vim
apt-get install -y unp
apt-get install -y htop
apt-get install -y wakeonlan

# Install tmux 2.0 (1.9+ is required for plugins)
apt-get update
apt-get install -y python-software-properties software-properties-common
add-apt-repository -y ppa:pi-rho/dev
apt-get update
apt-get install -y tmux=2.0-1~ppa1~t

apt-get install -y virtualbox
apt-get install -y vagrant

# recommended way to install docker & dokku
wget -qO- https://get.docker.com/ | sh
wget https://raw.github.com/progrium/dokku/v0.3.25/bootstrap.sh
DOKKU_TAG=v0.3.25 bash bootstrap.sh


apt-get install -y openssh-server
apt-get install -y fail2ban

apt-get install -y sqlite
apt-get install -y postgres
apt-get install -y mysql

# install mongodb
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.0 main" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
apt-get update
apt-get install -y mongodb-org

# install transmission torrent client & daemon
add-apt-repository -y ppa:transmissionbt/ppa
apt-get update
apt-get install -y transmission-cli transmission-common transmission-daemon

apt-get install nodejs
apt-get install npm

# install vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# change owner to current user since curl running under sudo makes plug.vim unable to function
chown -R $USER ~.vim/

# install tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

apt-get install -y golang
apt-get install -y python python3 python-dev python-pip python3-dev python3-pip

add-apt-repository -y ppa:neovim-ppa/unstable
apt-get update
apt-get install -y neovim


