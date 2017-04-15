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

sudo apm upgrade

ln -sf "${currentDir}/config.cson" $HOME/.atom/config.cson
ln -sf "${currentDir}/init.coffee" $HOME/.atom/init.coffee
ln -sf "${currentDir}/keymap.cson" $HOME/.atom/keymap.cson
ln -sf "${currentDir}/snippets.cson" $HOME/.atom/snippets.cson
ln -sf "${currentDir}/styles.less" $HOME/.atom/styles.less

sudo apt-get -y install inotify-tools

inotifywait -q -m -r -e close_write "${currentDir}" |
while read -r filename event; do
  sleep 60
  git pull origin master
  git add .
  git commit -m "Updated atom-quickstart configuration: ${filename} / ${event}"
  git push origin master
done
