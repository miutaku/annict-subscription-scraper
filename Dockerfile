FROM golang:1.23 AS builder
WORKDIR /app
COPY . .
RUN go build -o annict-subscription-scraper

# Create an image
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/annict-subscription-scraper .
EXPOSE 8080

CMD ["/app/annict-subscription-scraper"]
