.PHONY: all
all: install

.PHONY: deb
deb:
	debuild -us -uc

.PHONY: install
install: profile_dir
	install -m 0644 etc/profile.d/appscale.sh $(DESTDIR)/etc/profile.d/appscale.sh
	install -m 0644 etc/profile.d/appscale-tools.sh $(DESTDIR)/etc/profile.d/appscale-tools.sh

.PHONY: profile_dir
profile_dir:
	mkdir -p $(DESTDIR)/etc/profile.d
