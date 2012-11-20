.PHONY: all
all: test

.PHONY: test
test:

.PHONY: deb_signed
deb_signed:
	debuild

.PHONY: deb_source
deb_source:
	debuild -S

.PHONY: deb
deb:
	debuild -us -uc

.PHONY: install
install: profile_dir
	mkdir -p $(DESTDIR)/usr/local/appscale-tools
	cp -r bin lib templates $(DESTDIR)/usr/local/appscale-tools
	cp LICENSE README $(DESTDIR)/usr/local/appscale-tools

	install -m 0644 etc/profile.d/appscale.sh $(DESTDIR)/etc/profile.d/appscale.sh
	install -m 0644 etc/profile.d/appscale_tools.sh $(DESTDIR)/etc/profile.d/appscale_tools.sh
	install -m 0644 etc/profile.d/appscale_config.sh $(DESTDIR)/etc/profile.d/appscale_config.sh

.PHONY: profile_dir
profile_dir:
	mkdir -p $(DESTDIR)/etc/profile.d
