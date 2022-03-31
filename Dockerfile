FROM node:8.17.0

# experimental
RUN apt-get update -y \
    && apt-get install -y sudo fakechroot busybox-static \
    && rm -r /var/lib/apt/lists/*

RUN mkdir /app && chown -R 1000:1000 /app
COPY --chown=1000:1000 . /app/makyek-jd

USER 1000:1000
RUN git clone https://github.com/next-makyek/makyek-judge.git /app/makyek-judge

WORKDIR /app/makyek-judge
RUN npm ci \
    && npm run build

WORKDIR /app/makyek-jd
RUN npm ci \
    && npm run build
