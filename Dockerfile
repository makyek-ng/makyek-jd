FROM node:8.17.0

# note: fakechroot is used only for debugging. DO NOT use in production.
RUN apt-get update -y \
    && apt-get install -y sudo coreutils fakechroot busybox-static \
    && rm -r /var/lib/apt/lists/*

RUN mkdir /app
COPY --chown=0:0 . /app/makyek-jd

RUN git clone https://github.com/next-makyek/makyek-judge.git /app/makyek-judge

WORKDIR /app/makyek-judge
RUN npm ci \
    && npm run build

WORKDIR /app/makyek-jd
RUN npm ci \
    && npm run build
