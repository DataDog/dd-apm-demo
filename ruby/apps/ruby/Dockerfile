# Cannot use slim container because `bundle install` wants to build things
FROM ruby:2.7.2-buster
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends procps tini && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/app/
COPY Gemfile .
RUN bundle install
COPY . .
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["bash", "run.sh"]
