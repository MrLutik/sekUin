FROM golang:1.22

ENV CGO_ENABLED=0 
ENV GOOS=linux 

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

WORKDIR /src

ENTRYPOINT ["/entrypoint.sh"]
