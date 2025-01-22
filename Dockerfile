FROM alpine AS base

RUN apk add curl
RUN mkdir -p /usr/lib/extension-release.d/
RUN echo ID=_any > /usr/lib/extension-release.d/extension-release.the-mind

FROM base AS mosh

RUN curl -L -o /usr/bin/mosh-server \
    https://github.com/blinksh/mosh-static-multiarch/releases/download/1.4.0%2Bblink-17.3.0/mosh-server-1.4.0+blink-17.3.0-linux-amd64
RUN chmod +x /usr/bin/mosh-server

FROM base AS nnn

RUN curl -L -O https://github.com/jarun/nnn/releases/download/v5.0/nnn-icons-static-5.0.x86_64.tar.gz
RUN tar xvf nnn-icons-static-5.0.x86_64.tar.gz
RUN mv nnn-icons-static /usr/bin/nnn

FROM base AS tmux

RUN curl -L -o /usr/bin/tmux https://github.com/pythops/tmux-linux-binary/releases/download/v3.5a/tmux-linux-x86_64
RUN chmod +x /usr/bin/tmux

FROM scratch

COPY --from=base /usr/lib/extension-release.d /usr/lib/extension-release.d

COPY --from=mosh /usr/bin/mosh-server /usr/bin/mosh-server
COPY --from=nnn /usr/bin/nnn /usr/bin/nnn
COPY --from=tmux /usr/bin/tmux /usr/bin/tmux
