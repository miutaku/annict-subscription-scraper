# syntax=docker/dockerfile:1

FROM golang:1.26-alpine AS builder
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o /out/annict-subscription-scraper .

FROM alpine:3.24
RUN apk add --no-cache ca-certificates \
    && addgroup -S app \
    && adduser -S -G app app
WORKDIR /app
COPY --from=builder /out/annict-subscription-scraper .
USER app
EXPOSE 8080
CMD ["/app/annict-subscription-scraper"]
