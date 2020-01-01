ARG BASE_IMAGE=iboss/alpine

### BUILDER ####################################################################

FROM ${BASE_IMAGE} AS builder
COPY rootfs /app
RUN set -ex; \
  chmod +x /app/service/health

### IMAGE ######################################################################

FROM ${BASE_IMAGE}

RUN set -x && \
  apk add --no-cache \
    clamav-daemon \
    clamav-db \
    clamav-libunrar \
    && \
  mkdir /run/clamav && \
  chown clamav:clamav /run/clamav && \
  clamd --version

COPY --from=builder /app /
