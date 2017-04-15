all: create_lib copy_resources make_symlink

create_lib: 
$(shell mkdir -p /usr/lib/atom-quickstart && chown -R $(USER):$(USER) /usr/lib/atom-quickstart && chmod -R 755 /usr/lib/atom-quickstart)

copy_resources:
$(shell cp -R . /usr/lib/atom-quickstart)

change_origin:
$(shell git remote set-url origin $(ORIGIN))

make_symlink:
$(shell ln -sf /usr/lib/atom-quickstart/install.sh /usr/bin/atom-quickstart && chown $(USER):$(USER) /usr/bin/atom-quickstart && chmod 755 /usr/bin/atom-quickstart)
