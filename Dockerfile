FROM lscr.io/linuxserver/qbittorrent:4.6.7

LABEL org.opencontainers.image.source="https://github.com/silverfoxonline/qBittorrent"
LABEL org.opencontainers.image.description="qBittorrent 4.6.7 with customized WebUI"

COPY src/webui/www /app/qbittorrent-webui
COPY docker/custom-cont-init.d/90-enable-custom-webui /custom-cont-init.d/90-enable-custom-webui

RUN chmod +x /custom-cont-init.d/90-enable-custom-webui