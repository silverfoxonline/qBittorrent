FROM ubuntu:24.04 AS webui-translations

RUN apt-get update \
    && apt-get install -y --no-install-recommends qt6-tools-dev-tools \
    && rm -rf /var/lib/apt/lists/*

COPY src/webui/www /webui
RUN lrelease /webui/translations/*.ts

FROM lscr.io/linuxserver/qbittorrent:4.6.7

LABEL org.opencontainers.image.source="https://github.com/silverfoxonline/qBittorrent"
LABEL org.opencontainers.image.description="qBittorrent 4.6.7 with customized WebUI"

COPY --from=webui-translations /webui /app/qbittorrent-webui
COPY docker/custom-cont-init.d/90-enable-custom-webui /custom-cont-init.d/90-enable-custom-webui

RUN chmod +x /custom-cont-init.d/90-enable-custom-webui
