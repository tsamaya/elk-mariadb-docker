# elk-mariadb-docker

### about

This Docker Compose file sets up Elastic stack (ELK stack) and syncs MariaDB data into Elasticsearch. The Logstash pipeline configuration file is currently set to sync every minute and avoids duplication of data. 

### get started

To use this this Compose file, simply run `docker-compose up --build`.

> NOTE: macOS defaults to giving the Docker engine 2GB of memory. You will want to change this to 4GB to run this setup reliably (or else elasticsearch will
intermittently crash).

Wait for logstash to synchronize data into Elasticsearch then open your Browser on http://localhost

___to be continued___

### License

Licensed under the MIT License

A copy of the license is available in the repository's [LICENSE](LICENSE) file.
