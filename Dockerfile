FROM fedora:latest

RUN dnf install -y --setopt=tsflags=nodocs \
	redis grafana-pcp pcp-zeroconf \
	#pcp-pmda-bcc pcp-pmda-bpftrace bcc-tools bpftrace \
	#kmod procps \
	&& \
    dnf clean all && \
    /bin/true
    #/var/lib/pcp/pmdas/{bcc,bpftrace}/.NeedInstall

#COPY grafana.ini /etc/grafana/grafana.ini
COPY grafana-configuration.service /etc/systemd/system
COPY datasource.yaml /usr/share/grafana/conf/provisioning/datasources/grafana-pcp.yaml
#COPY bpftrace.conf /var/lib/pcp/pmdas/bpftrace/bpftrace.conf
COPY datasource.yaml /etc/grafana/provisioning/datasources/grafana-pcp.yaml

RUN systemctl enable redis grafana-server grafana-configuration
RUN systemctl enable pmcd pmie pmproxy
#RUN systemctl enable pmproxy
#RUN systemctl disable pmlogger

# PCP archives (auto-discovered by pmproxy), REST API, PCP port
VOLUME ["/var/log/pcp/pmlogger"]
EXPOSE 44322
EXPOSE 44321

# Redis RDB files and Redis RESP port
VOLUME ["/var/lib/redis"]
EXPOSE 6379

# Grafana DB and REST API port
VOLUME ["/var/lib/grafana"]
EXPOSE 3000

CMD ["/usr/sbin/init"]
