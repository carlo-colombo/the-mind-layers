FROM alpine AS build

RUN apk add curl
RUN curl -L -o /usr/bin/mosh-server \
    https://github.com/blinksh/mosh-static-multiarch/releases/download/1.4.0%2Bblink-17.3.0/mosh-server-1.4.0+blink-17.3.0-linux-amd64

RUN mkdir -p /usr/lib/extension-release.d/
RUN echo ID=_any > /usr/lib/extension-release.d/extension-release.the-mind

FROM scratch

COPY --from=build /usr/bin/mosh-server /usr/bin/mosh-server
COPY --from=build /usr/lib/extension-release.d /usr/lib/extension-release.d
