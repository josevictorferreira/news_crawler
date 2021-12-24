FROM elixir:1.13-alpine as build

RUN adduser -D app

USER app

ENV MIX_ENV=prod

RUN apk add --update build-base

WORKDIR /home/app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./

RUN mix do deps.get, deps.compile

COPY priv priv

RUN mix phx.digest

COPY lib lib

RUN mix do compile, release

FROM build

WORKDIR /home/app

COPY --from=build /app/_build/prod/app_name-*.tar.gz ./

CMD ["/bin/bash"]
