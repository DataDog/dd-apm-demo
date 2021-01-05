## Installation

Install [direnv](https://github.com/direnv/direnv) for applying local settings.

1. Copy `.envrc.sample` to `.envrc` and add your Datadog API key.
2. `direnv allow` to load the env var.
3. `docker-compose run --rm app /bin/bash -c 'bundle install'`
4. `docker-compose run --rm app /bin/bash -c 'yarn install'`
4. `docker-compose run --rm app /bin/bash -c 'rake db:migrate'`
4. `docker-compose run --rm app /bin/bash -c 'rails webpacker:install'`
4. ```
   docker-compose exec mysql mysql -u root -p -D rails_dev --execute=" \
   CREATE USER 'rails_readonly'@'%' IDENTIFIED BY 'rails'; \
   GRANT ALL ON rails_dev.* TO 'rails_readonly'@'%'; \
   "
   ```

## Running the application

### To monitor performance of Docker containers with Datadog

```sh
docker run --rm --name dd-agent  -v /var/run/docker.sock:/var/run/docker.sock:ro -v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro -e API_KEY=$DD_API_KEY datadog/docker-dd-agent:latest
```

### Web server

Run `docker-compose up` to auto-start the webserver. It should bind to `localhost:3000`.

Alternatively, you can run it manually with:

```sh
docker-compose run --rm -p 3000:3000 app /bin/bash -c 'bundle exec rails s -b 0.0.0.0'
```

##### Available Routes

```sh
```

### Load tester

Docker configuration automatically creates and runs [Wrk](https://github.com/wg/wrk) load testing containers.

You can modify `config/wrk/test.sh` and `config/wrk/*.lua` to change how the load tests operates.
