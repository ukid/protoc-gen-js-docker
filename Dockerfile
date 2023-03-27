FROM --platform=linux/amd64 ubuntu:20.04
ENV DIR=/data
WORKDIR $DIR

RUN apt -y update && \
    apt -y upgrade && \
    apt -y install autoconf automake libtool curl make g++ unzip git wget && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/ukid/protobuf.git && \
    cd protobuf && \
    git checkout v3.19.4_js_fromobject && \
    git submodule update --init --recursive && \
    ./autogen.sh && \
    ./configure && \
    make -j$(nproc) && \
    make install && \
    rm -rf ./*

RUN wget -qO /usr/local/bin/protoc-gen-grpc-web https://github.com/grpc/grpc-web/releases/download/1.4.2/protoc-gen-grpc-web-1.4.2-linux-x86_64	&& \
    chmod +x /usr/local/bin/protoc-gen-grpc-web

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh


ENTRYPOINT ["docker-entrypoint.sh"]
CMD [""]