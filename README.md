# atom-quickstart
A bash script to set up atom.io for Debian destros!

## Configuration

You will need to ensure that the origin git repository is your own.  You can change your origin repo with the following command:

```
git remote set-url origin git@github.com:USERNAME/OTHERREPOSITORY.git
```

## Usage

```
sudo bash ./install.sh
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
