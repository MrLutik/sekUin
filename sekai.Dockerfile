# Build app
FROM ubuntu:20.04 AS builder

# Avoid prompts from apt
ARG DEBIAN_FRONTEND=noninteractive

# Update packages and Install essentials in one layer
RUN apt-get update -y && \
    apt-get install -y git build-essential jq wget

# Install Golang
RUN wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz -O /tmp/go.tar.gz && \
    tar -C /usr/local -xzf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz

# Set PATH for Golang
ENV PATH="$PATH:/usr/local/go/bin"

# Cloning sekai repo and install
RUN git clone -c http.postBuffer=1048576000 --depth 1 https://github.com/MrLutik/sekai.git /bsekai && \
    cd /bsekai && \
    make install 

# Run app
FROM scratch

# Avoid prompts from apt
ARG DEBIAN_FRONTEND=noninteractive

# Copy artifacts
COPY --from=builder /sekaid /sekaid

# Start sekai
ENTRYPOINT ["/sekai/sekaidCaller"]

# Expose the default Tendermint port
EXPOSE 26657
EXPOSE 26656
