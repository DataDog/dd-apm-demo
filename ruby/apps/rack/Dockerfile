# Select base image
ARG base_image=delner/datadog-apm-demo:rb-2.7
FROM ${base_image}

# Setup directory
RUN mkdir /app
WORKDIR /app

# Setup specific version of ddtrace, if specified.
ARG ddtrace_git
ENV DD_DEMO_ENV_GEM_GIT_DDTRACE ${ddtrace_git}

ARG ddtrace_ref
ENV DD_DEMO_ENV_GEM_REF_DDTRACE ${ddtrace_ref}

# Install dependencies
COPY Gemfile /app/Gemfile
RUN bundle install

# Add files
COPY . /app

# Set entrypoint
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["bin/setup && bin/dd-demo"]
