
FROM golang:1.25-alpine as builder
WORKDIR /build

COPY ./src/go.mod .
COPY ./src/go.sum .

RUN go mod download
COPY ./src .
RUN CGO_ENABLED=0 GOOS=linux go build -o /main main.go

FROM alpine:3

COPY --from=builder main /bin/main
ENTRYPOINT ["/bin/main"]
