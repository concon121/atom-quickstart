#!/bin/bash

file=`basename $0`
me=${file:0:-3}
installed=`apm ls | grep "$me"`
if [ -z "${installed}" ]
then
  sudo apm install "$me"
fi

# =============================================================================
# Add apt custom repos
# =============================================================================
crystal_installed=`which crystal`
if [ -z "${crystal_installed}" ]
then
  curl https://dist.crystal-lang.org/apt/setup.sh | sudo bash
  apt-key adv --keyserver keys.gnupg.net --recv-keys 09617FD37CC06B54
  echo "deb https://dist.crystal-lang.org/apt crystal main" > /etc/apt/sources.list.d/crystal.list
fi

dmd_installed=`which dmd`
if [ -z "${dmd_installed}" ]
then
  sudo wget http://master.dl.sourceforge.net/project/d-apt/files/d-apt.list -O /etc/apt/sources.list.d/d-apt.list
  sudo apt-get update && sudo apt-get -y --allow-unauthenticated install --reinstall d-apt-keyring && sudo apt-get update
fi
# =============================================================================
# apt installs
# =============================================================================
apt-get update
sudo apt-get -y install python python3 python-pip crystal dmd-bin ruby-full cmake

# =============================================================================
# pip installs
# =============================================================================
sudo pip install --upgrade beautysh autopep8 pybeautifier sqlparse

# =============================================================================
# Ruby Gems
# =============================================================================
sudo gem install htmlbeautifier puppet-lint rubocop ruby-beautify bundler rake

# =============================================================================
# DFMT
# =============================================================================
dfmt_installed=`which dfmt`
if [ -z "${dfmt_installed}" ]
then
  sudo git clone https://github.com/Hackerpilot/dfmt.git
  cd dfmt
  git submodule update --init --recursive
  sudo make
  sudo ln -s ./bin/dfmt /usr/bin/dfmt
  cd ..
fi
