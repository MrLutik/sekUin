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
RUN git clone -c http.postBuffer=1048576000 --depth 1 https://github.com/KiraCore/sekai.git /sekai && \
    cd /sekai && \
    make install && \
    echo '#!/bin/bash\n\
         \n\
         # Default to showing the Ansible version if no command is specified\n\
         if [ $# -eq 0 ]; then\n\
             exec sekaid version\n\
         else\n\
             exec "$@"\n\
         fi' > /entrypoint.sh && \ 
    chmod +x /entrypoint.sh

# Run app
FROM scratch

# Avoid prompts from apt
ARG DEBIAN_FRONTEND=noninteractive

# Copy artifacts
COPY --from=builder /sekaid /bin/sekaid
COPY --from=builder /entrypoint.sh /entrypoint.sh

# Create working dir
WORKDIR /sekai

# Start sekai
ENTRYPOINT ["/entrypoint.sh"]

# Expose the default Tendermint port
EXPOSE 26657
EXPOSE 26656
