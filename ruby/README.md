# Datadog APM Ruby demo applications

Ruby demo applications configured with Datadog APM, which can be used to generate sample traces/profiles.

## Quickstart

1. Build Ruby base images:

    ```
    docker build -t delner/datadog-apm-demo:rb-2.2 -f images/2.2/Dockerfile ./images
    docker build -t delner/datadog-apm-demo:rb-2.5 -f images/2.5/Dockerfile ./images
    docker build -t delner/datadog-apm-demo:rb-2.7 -f images/2.7/Dockerfile ./images
    ```

2. Select application to run, change directory, and follow `README.md` for further setup and instructions:

    - `apps/rack`: Rack application
    - `apps/rails-five`: Rails 5 application
    - `apps/rails-six`: Rails 6 application
    - `apps/sinatra`: Sinatra application

### Base images

The `images/` folders hosts some images for Ruby applications.

- `delner/datadog-apm-demo:rb-2.2` / `images/2.2/Dockerfile`: MRI Ruby 2.2
- `delner/datadog-apm-demo:rb-2.5` / `images/2.5/Dockerfile`: MRI Ruby 2.5
- `delner/datadog-apm-demo:rb-2.7` / `images/2.7/Dockerfile`: MRI Ruby 2.7

Ruby base images include `Datadog::DemoEnv` and other helpers.

## Debugging

### Profiling memory

Create a memory heap dump via:

```sh
# Profile for 5 minutes, dump heap to /data/app/ruby-heap.dump
# Where PID = process ID
bundle exec rbtrace -p PID -e 'Thread.new{GC.start; require "objspace"; ObjectSpace.trace_object_allocations_start; sleep(300); io=File.open("/data/app/ruby-heap.dump", "w"); ObjectSpace.dump_all(output: io); io.close}'
```

Then analyze it using `analyzer.rb` (built into the Ruby base images) with:

```sh
# Group objects by generation
ruby /vendor/dd-demo/datadog/analyzer.rb /data/app/ruby-heap.dump

# List objects in GEN_NUM, group by source location
ruby /vendor/dd-demo/datadog/analyzer.rb /data/app/ruby-heap.dump GEN_NUM

# List objects in all generations, group by source location, descending.
ruby /vendor/dd-demo/datadog/analyzer.rb /data/app/ruby-heap.dump objects

# List objects in all generations, group by source location, descending.
# Up to generation END_GEN.
ruby /vendor/dd-demo/datadog/analyzer.rb /data/app/ruby-heap.dump objects END_GEN

# List objects in all generations, group by source location, descending.
# Between generations START_GEN to END_GEN inclusive.
ruby /vendor/dd-demo/datadog/analyzer.rb /data/app/ruby-heap.dump objects END_GEN START_GEN
```
