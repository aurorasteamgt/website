FROM debian:bookworm-slim

ARG HUGO_VERSION=0.156.0
ARG DART_SASS_VERSION=1.97.3
ARG GO_VERSION=1.25.6
ARG NODE_VERSION=24.13.0
ARG TARGETARCH

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    tar \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Go
RUN curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-${TARGETARCH}.tar.gz" \
    | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"

# Dart Sass (arch suffix: x64 | arm64)
RUN set -eu; \
    case "${TARGETARCH}" in \
      amd64) SASS_ARCH=x64 ;; \
      arm64) SASS_ARCH=arm64 ;; \
      *) echo "Unsupported arch: ${TARGETARCH}" >&2; exit 1 ;; \
    esac; \
    curl -fsSLJO "https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-${SASS_ARCH}.tar.gz" && \
    tar -C /usr/local -xzf "dart-sass-${DART_SASS_VERSION}-linux-${SASS_ARCH}.tar.gz" && \
    rm "dart-sass-${DART_SASS_VERSION}-linux-${SASS_ARCH}.tar.gz"
ENV PATH="/usr/local/dart-sass:${PATH}"

# Hugo extended (arch suffix: amd64 | arm64)
RUN curl -fsSLJO "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${TARGETARCH}.tar.gz" && \
    mkdir -p /usr/local/hugo && \
    tar -C /usr/local/hugo -xzf "hugo_extended_${HUGO_VERSION}_linux-${TARGETARCH}.tar.gz" && \
    rm "hugo_extended_${HUGO_VERSION}_linux-${TARGETARCH}.tar.gz"
ENV PATH="/usr/local/hugo:${PATH}"

# Node.js (arch suffix: x64 | arm64)
RUN set -eu; \
    case "${TARGETARCH}" in \
      amd64) NODE_ARCH=x64 ;; \
      arm64) NODE_ARCH=arm64 ;; \
      *) echo "Unsupported arch: ${TARGETARCH}" >&2; exit 1 ;; \
    esac; \
    curl -fsSL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz" \
    | tar -C /usr/local --strip-components=1 -xJ
# node-v...-linux-<arch>.tar.xz already unpacks into /usr/local/{bin,lib,include,share}

RUN git config --system --add safe.directory /src && \
    git config --system core.quotepath false

WORKDIR /src
ENTRYPOINT ["sh"]