#!/bin/bash

file=`basename $0`
me=${file:0:-3}
installed=`apm ls | grep "$me"`
if [ -z "${installed}" ]
then
  sudo apm install "$me"
fi
