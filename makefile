all: create_lib copy_resources make_symlink

create_lib: 
mkdir -p /usr/lib/atom-quickstart

copy_resources:
cp -R ./* /usr/lib/atom-quickstart

make_symlink:
ln -sf /usr/lib/install.sh /usr/bin/atom-quickstart
