FROM ruby:3.2.2-alpine AS build

ARG AUTOMATICALLY_MIGRATE=true
ENV AUTOMATICALLY_MIGRATE=$AUTOMATICALLY_MIGRATE

# Install base packages and other software
RUN apk add --no-cache nodejs build-base libxml2-dev libpq-dev libxslt-dev tzdata \
  git openssh

WORKDIR /app

COPY Gemfile Gemfile.lock ./

ENV BUNDLE_PATH /bundle

RUN bundle config --global build.nokogiri --use-system-libraries && \
  bundle config git.allow_insecure true

# ----------------------------------------------
FROM build AS local

ENTRYPOINT ["/app/entrypoint.local.sh"]

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

