# Build stage
FROM golang:1.23 AS builder
WORKDIR /app
COPY . .
RUN go build -o annict-subscription-scraper ./main.go

# Runtime stage
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/annict-subscription-scraper .
RUN apk add --no-cache libc6-compat
EXPOSE 8080
CMD ["/root/annict-subscription-scraper"]
