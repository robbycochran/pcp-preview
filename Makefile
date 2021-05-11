SUDO := sudo -H
ifeq ($(shell uname -s),Darwin)
	SUDO :=
endif

default: pbuild prun

pbuild:
	$(SUDO) podman build -t pcp-preview .

prun:
	$(SUDO) podman run --privileged -v /lib/modules:/lib/modules:ro -v /usr/src:/usr/src:ro -p 3000:3000 pcp-preview

dbuild:
	$(SUDO) docker build -t pcp-preview .

drun:
	$(SUDO) docker run -d --name pcp -v /tmp/pcp:/host --privileged -v pcp-archives:/var/log/pcp/pmlogger -v /lib/modules:/lib/modules:ro -v /usr/src:/usr/src:ro -p 3000:3000 pcp-preview
