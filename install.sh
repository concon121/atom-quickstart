#!/bin/bash

currentDir=`pwd`

installed=`which atom`
if [ -z "${installed}" ]
then
  sudo add-apt-repository ppa:webupd8team/atom
  sudo apt-get -y update
  sudo apt-get -y install atom
fi

plugins=(`ls plugins`)
for plugin in "${plugins[@]}"
do
  ./plugins/${plugin}
done

ln -s "${currentDir}/config.cson" $HOME/.atom/config.cson

sudo apt-get -y install inotify-tools

inotifywait -q -m -e close_write "${currentDir}/config.cson" |
while read -r filename event; do
  git add "${currentDir}/config.cson"
  git commit -m "Updated atom.io configuration"
  git push origin master
done
