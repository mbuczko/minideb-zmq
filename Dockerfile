FROM bitnami/minideb:bullseye
RUN install_packages libzmq5 ca-certificates

# Install s6 for process supervision.
ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer
RUN /tmp/s6-overlay-amd64-installer / && rm /tmp/s6-overlay-amd64-installer

# For statics
RUN mkdir /var/www

# Copy s6 init & service definitions.
COPY etc/services.d /etc/services.d

# The kill grace time is set to zero because our app handles shutdown through SIGTERM.
ENV S6_KILL_GRACETIME=0

# Sync disks is enabled so that data is properly flushed.
ENV S6_SYNC_DISKS=1
