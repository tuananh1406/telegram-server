FROM ubuntu:18.04

ENV TELEGRAM_API_ID 7194680
ENV TELEGRAM_API_HASH 1e15fb7e7d4c247ea42fd91fcaf4aea9

RUN apt-get update

# Cài đặt các package depend
RUN apt-get install -y make git zlib1g-dev libssl-dev gperf cmake g++ tree iputils-ping

# Build từ source
RUN rm -rf telegram-bot-api
RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git
WORKDIR telegram-bot-api
RUN rm -rf build
RUN mkdir build 
WORKDIR build
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=..  ..  && cmake --build . --target install
WORKDIR ../bin
RUN tree >> /tmp/tree.txt
RUN echo $(tree -L 2 bin)
ENTRYPOINT ["./telegram-bot-api", "--http-port=8100", "--local"]
