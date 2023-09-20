FROM golang:latest as builder
ARG CLI_VERSION=develop
WORKDIR /src
COPY . .
RUN go build -o bosh --ldflags "-X 'cmd.VersionLabel='$CLI_VERSION'"

FROM alpine
COPY --from=builder /src/bosh /usr/bin
COPY ./bosh-cli /bin/bosh
RUN apk add --no-cache git
