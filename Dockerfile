FROM hexpm/elixir:1.11.2-erlang-23.3.4.4-alpine-3.13.3

RUN apk update && apk upgrade && \
    apk add postgresql-client && \
    apk add nodejs npm && \
    apk add build-base && \
    rm -rf /var/cache/apk/*

ENV MIX_ENV prod
ENV DATABASE_URL ecto://postgres:postgres@db/too_short

RUN mix do local.hex --force, local.rebar --force

COPY mix.* ./

RUN mix do deps.get --only prod
RUN mix deps.compile

COPY assets/package.json assets/

RUN cd assets && \
    npm install

COPY . ./

RUN cd assets/ && \
    npm run deploy && \
    cd - && \
    mix do compile, phx.digest

RUN chmod +x start-up.sh

CMD ["/start-up.sh"]