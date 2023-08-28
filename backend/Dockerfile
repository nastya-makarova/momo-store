FROM golang:1.20

ARG VERSION=${VERSION}

WORKDIR /usr/src/app
COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .

RUN go build ./cmd/api

EXPOSE 8081

CMD ["./api"]
