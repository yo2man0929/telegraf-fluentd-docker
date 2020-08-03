# TELEGRAF-DOCKER
telegraf-docker uses `telegraf` configured with the `docker` input plugin and the `YAMAS` output plugin.  telegraf-docker runs as DaemonSet inside a Kubernetes cluster.

* [telegraf](https://git.ouroath.com/pages/monitoring/yamas_userguide_2.0/telegraf/telegraf/) - Internal `telegraf` documentation
* [docker](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/docker) - telgraf input plugin

## Agent/YAMAS Output Configuration
| Environment Variable | Type | Description |
|------|-------|-------------|
| AGENT_DEBUG | Boolean | Debug |
| YAMAS_OUTPUT_NAMESPACE | String | Namespace to write metrics too. |
| YAMAS_OUTPUT_EC2_TAGS_ENABLE | Boolean | AWS EC2 instance tags enabled. |
| YAMAS_OUTPUT_TLS_ENABLE | Boolean | TLS config |
| YAMAS_OUTPUT_TLS_CA | String | TLS CA |
| YAMAS_OUTPUT_TLS_CERT | String | Athenz TLS Cert |
| YAMAS_OUTPUT_TLS_KEY | String | Athenz TLS Key |
| YAMAS_OUTPUT_REFRESH_FREQUENCY | String | Automatically reload client certificates. Disabled if 0. |
| YAMAS_OUTPUT_ENVIRONMENT | String | `public` for hosts running on AWS. `private` for hosts running on the Oath! network. |

* [telegraf agent configuration](https://github.com/influxdata/telegraf/blob/master/docs/CONFIGURATION.md) - Deatils on the various configuration options

### test steps 
```
docker network create test123

docker-compose up --build

curl -i -XPOST 'http://localhost:4080/test' --data-binary '{"value1": 42, "value2": 42}'

```
### fluent-docker

```
modify fluentd.conf 

```
### log generator 
modify docker-compose.yaml
```

command: sh -c 'while true; do date +"%s provider=50"; sleep 10; done'

```
### after running the dockers, check the collector-writer.log in you `PWD` folder