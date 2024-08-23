ARG CADDY_VERSION=2.8
FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/yroc92/postgres-storage \
    --with github.com/ss098/certmagic-s3 \
    --with github.com/mholt/caddy-l4

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
ADD ./Caddyfile.sniproxy /etc/caddy

CMD ["caddy", "docker-proxy"]
