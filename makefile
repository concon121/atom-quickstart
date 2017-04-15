all: create_lib copy_resources make_symlink

create_lib: 
<\t>$(shell mkdir -p /usr/lib/atom-quickstart)

copy_resources:
<\t>$(shell cp -R ./* /usr/lib/atom-quickstart)

make_symlink:
<\t>$(shell ln -sf /usr/lib/atom-quickstart/install.sh /usr/bin/atom-quickstart)
