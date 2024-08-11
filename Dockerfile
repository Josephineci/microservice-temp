FROM golang:1.17.5-alpine3.15 as build

WORKDIR /source

COPY . .

ARG VER

RUN CGO_ENABLED=0 go build -ldflags "-s -w -X main.ver=${VER}" -o pacman main.go
 

FROM alpine:3.15

COPY --from=build /source/pacman /pacman

EXPOSE 8081

ENTRYPOINT ["./pacman"]
