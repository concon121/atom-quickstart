#!/bin/bash
set -x

running=`ps -aux | grep "/bin/bash /usr/bin/atom-quickstart" | wc -l`

if [ "${running}" -lt 4 ]
then
  echo "Starting atom-quickstart"
  currentDir=`pwd`

  installed=`which atom`
  if [ -z "${installed}" ]
  then
    echo "Installing atom.io"
    sudo add-apt-repository ppa:webupd8team/atom
    sudo apt-get -y update
    sudo apt-get -y install atom
  else 
    echo "Atom.io is already installed!"
  fi

  echo "Installing atom.io plugins"
  plugins=(`ls plugins`)
  for plugin in "${plugins[@]}"
  do
    ./plugins/${plugin}
  done

  echo "Ensuring atom.io plugins are up to date"
  sudo apm upgrade -c false

  echo "Moving atom.io configuration"
  ln -sf "${currentDir}/config/config.cson" $HOME/.atom/config.cson
  ln -sf "${currentDir}/config/init.coffee" $HOME/.atom/init.coffee
  ln -sf "${currentDir}/config/keymap.cson" $HOME/.atom/keymap.cson
  ln -sf "${currentDir}/config/snippets.cson" $HOME/.atom/snippets.cson
  ln -sf "${currentDir}/config/styles.less" $HOME/.atom/styles.less

  echo "Watching atom.io configuration for changes"
  sudo apt-get -y install inotify-tools
  inotifywait -q -m -r -e close_write "${currentDir}" |
  while read -r filename event; do
    sleep 60
    git pull origin master
    git add .
    git commit -m "Updated atom-quickstart configuration: ${filename} / ${event}"
    git push origin master
  done
else
  echo "atom-quickstart is already running"
fi
