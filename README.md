# Datadog APM demo applications

Demo applications configured with Datadog APM, which can be used to generate sample traces/profiles.

## Quickstart

1. Build base images:

    ```
    docker build -t delner/datadog-apm-demo:wrk -f images/wrk/Dockerfile ./images/wrk
    ```

2. Choose a language and follow `README.md` for instructions on how to run demo apps for a particular language:

    - `ruby`: Ruby APM

### Base images

The `images/` folder hosts some common images used by demo applications.

- `delner/datadog-apm-demo:wrk` / `images/wrk/Dockerfile`: `wrk` load testing application (for generating load)

### Configuration

The `config/` folder contains configuration files used in demo applications.

 - `agent.yml`: Default agent configuration file.
