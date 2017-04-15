# atom-quickstart
A bash script to set up atom.io for Debian destros!

* Auto-magically update all of your atom plugins.
* Install and manage new plugins.
* Backup all of your atom configuration to your github account.

## Installation

```
git clone https://github.com/concon121/atom-quickstart.git
cd atom-quickstart
sudo make ORIGIN=git@github.com:USERNAME/REPOSITORY.git USER=your-username
```

## Usage
You can add atom-quickstart to your $HOME/.bashrc file.  There are of course checks in place to ensure that only one instance of atom-quickstart is ever running.

```
sudo atom-quickstart &
```

## Adding a new plugin

A new plugin can be added to atom by simply creating a new script in the plugins directory which is named as the plugin you wish to install, and has the content below:

```
#!/bin/bash

file=`basename $0`
me=${file:0:-3}
installed=`apm ls | grep "$me"`
if [ -z "${installed}" ]
then
  sudo apm install "$me"
fi
``` 

If your plugin requires any custom extra dependencies which are not managed by apm, then add these to your script as well.

## Extending Configuration

Running the install script will kick off a file watcher that will watch all the configuration files in this repo and commit them to GitHub if they change.

To update the configuration, simply change your config directly in atom and the watcher will upload it to your git repository.
