## Installation

Install [direnv](https://github.com/direnv/direnv) for applying local settings.

1. Copy `.envrc.sample` to `.envrc` and add your Datadog API key.
2. `direnv allow` to load the env var.
3. `docker-compose build`
4. `docker-compose run --rm sinatra /bin/bash -c 'bundle install'`

## Running the application

### To monitor performance of Docker containers with Datadog

```sh
docker run --rm --name dd-agent  -v /var/run/docker.sock:/var/run/docker.sock:ro -v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro -e API_KEY=$DD_API_KEY datadog/docker-dd-agent:latest
```

### Web server

Run `docker-compose up` to auto-start the webserver. It should bind to `localhost:80`.

Alternatively, you can run it manually with:

```sh
docker-compose run --rm -p 80:80 sinatra /bin/bash -c 'bundle exec ddtracerb exec puma config.ru -C /app/puma.rb'
```

##### Available Routes

```sh
# Queue a job
curl -XPOST localhost/jobs

# Run test cases
curl -XPOST localhost/test/case_a
```

### Load tester

Docker configuration automatically creates and runs [Wrk](https://github.com/wg/wrk) load testing containers.

You can modify `config/wrk/test.sh` and `config/wrk/*.lua` to change how the load tests operates.
