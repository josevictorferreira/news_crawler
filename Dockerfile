FROM elixir:1.13-alpine as build

ENV MIX_ENV=prod

RUN apk add --update build-base

WORKDIR /home/app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./

RUN mix do deps.get, deps.compile

COPY lib lib

RUN mix do compile, release

RUN adduser -D app

USER app

WORKDIR /home/app

CMD ["./_build/prod/rel/news_crawler/bin/news_crawler", "start"]
