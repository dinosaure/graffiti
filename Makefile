
APP_NAME := graffiti
SERVER_PACKAGE := cairo,unix
CLIENT_PACKAGE :=

PORT := 8080

OCLOSURE := YES

###

all: local byte opt

LIBDIR := local/var/www/lib
JSDIR  := local/var/www/static

include Makefile.common

distclean::
	-rm css/closure
	-rm -r local
	-rm graffiti.p*.conf

####

DIRS = local/var/lib/ocsidbm local/var/run local/var/log \
       local/var/www/static local/var/www/lib local/etc

local: ${DIRS} local/var/www/static/css css/closure

local/var/www/static/css: local
	ln -fs $(shell pwd)/css local/var/www/static/css
css/closure:
	ln -fs $(shell ocamlfind query oclosure)/closure/goog/css/ css/closure
${DIRS}:
	mkdir -p $@

local/etc/graffiti.p${PORT}.conf: local graffiti.conf.in
	sed -e "s|%%SRC%%|$(shell pwd)|" \
	    -e "s|%%LIBDIR%%|${LIBDIR}|" \
	    -e "s|%%JSDIR%%|${JSDIR}|" \
	    -e "s|%%PORT%%|${PORT}|" \
	    $< > $@

run.local: local/etc/graffiti.p${PORT}.conf
	ocsigenserver -c local/etc/graffiti.p${PORT}.conf

run.opt.local: local/etc/graffiti.p${PORT}.conf
	ocsigenserver.opt -c local/etc/graffiti.p${PORT}.conf

####

install::
	install -d -m 775 ${INSTALL_USER} ${INSTALL_DIR}/static/css
	install -m 664 ${INSTALL_USER} css/*.css ${INSTALL_DIR}/static/css
	cd $(shell ocamlfind query oclosure)/closure/goog/css/ && \
	  find -type f -exec install -D -m 664 {} ${INSTALL_DIR}/static/css/closure/{} \;
