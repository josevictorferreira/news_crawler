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

WORKDIR /home/app

FROM elixir:1.13-alpine

RUN apk add tzdata

RUN adduser -D app

USER app

WORKDIR /home/app

COPY --chown=app --from=build /home/app/_build .

CMD ["./prod/rel/news_crawler/bin/news_crawler", "start"]
