FROM ruby:2.5.5

ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites
RUN set -ex; \
        apt-get update; \
        apt-get install -y --no-install-recommends \
            curl wget tar gzip gnupg ca-certificates tzdata locales; \
        rm -rf /var/lib/apt/lists/*;

# Install NodeJS
RUN set -ex; \
        apt-get update; \
        apt-get install -y --no-install-recommends nodejs; \
        rm -rf /var/lib/apt/lists/*;

# Install Yarn
RUN set -ex; \
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -; \
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list;

RUN set -ex; \
        apt-get update; \
        apt-get install -y --no-install-recommends yarn; \
        rm -rf /var/lib/apt/lists/*;

# Install databases
RUN set -ex; \
        apt-get update; \
        apt-get install -y --no-install-recommends \
            default-mysql-client postgresql-client sqlite3; \
        rm -rf /var/lib/apt/lists/*;

# Install dev tools
RUN set -ex; \
        apt-get update; \
        mkdir -p /usr/share/man/man1; \
        apt-get install -y --no-install-recommends \
            sudo git openssh-client rsync vim \
            net-tools netcat parallel unzip zip bzip2; \
        rm -rf /var/lib/apt/lists/*;

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Set language
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# Install RubyGems
RUN gem update --system
RUN mkdir -p "$GEM_HOME" && chmod -R 777 "$GEM_HOME"
RUN gem install bundler
ENV BUNDLE_SILENCE_ROOT_WARNING 1

# Setup demo environment includes
COPY ./include /vendor/dd-demo
ENV RUBYLIB /vendor/dd-demo
ENV RUBYOPT -rdatadog/demo_env
