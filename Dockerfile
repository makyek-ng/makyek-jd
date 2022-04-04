FROM node:8.17.0-buster
ARG DEBIAN_FRONTEND=noninteractive

# clang/llvm repo
COPY --chown=0:0 ./clang/llvm-snapshot.gpg.key /usr/share/keyrings/llvm-snapshot.gpg.key
COPY --chown=0:0 ./clang/clang.list /etc/apt/sources.list.d/clang.list

RUN apt-get update -y \
    && apt-get install -y sudo coreutils build-essential git busybox-static python3-psutil clang-14 \
    && rm -r /var/lib/apt/lists/*

RUN mkdir /app
COPY --chown=0:0 . /app/makyek-jd

RUN git clone https://github.com/makyek-ng/makyek-judge.git /app/makyek-judge

WORKDIR /app/makyek-judge
RUN npm ci \
    && npm run build

WORKDIR /app/makyek-jd
RUN npm ci \
    && npm run build
