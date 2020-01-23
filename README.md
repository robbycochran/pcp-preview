# Performance Co-Pilot Preview Container

[![Docker Repository on Quay](https://quay.io/repository/performancecopilot/pcp-preview/status "Docker Repository on Quay")](https://quay.io/repository/performancecopilot/pcp-preview)

This container contains preview versions of upcoming Performance Co-Pilot features.
It includes the following components:

* [Performance Co-Pilot](https://pcp.io)
* [grafana-pcp](https://github.com/performancecopilot/grafana-pcp) - PCP Plugin for Grafana
* [Redis](https://redis.io) - required for pmseries(1) for fast, scalable time series aggregation across multiple hosts
* [bpftrace](https://github.com/iovisor/bpftrace) - used by the bpftrace PMDA

## Run container
### Podman
```
sudo -H podman run -d --privileged -v /lib/modules:/lib/modules:ro -v /usr/src:/usr/src:ro -p 3000:3000 quay.io/performancecopilot/pcp-preview
```

### Docker
```
sudo -H docker run -d --privileged -v /lib/modules:/lib/modules:ro -v /usr/src:/usr/src:ro -p 3000:3000 quay.io/performancecopilot/pcp-preview
```

Grafana is ready at http://localhost:3000
