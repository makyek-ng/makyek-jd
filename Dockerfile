FROM node:8.17.0
COPY . /app
WORKDIR /app
RUN npm ci \
    && npm run build
USER 1000:1000
