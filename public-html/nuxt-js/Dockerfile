FROM node:12-alpine AS builder

LABEL maintainer David Sugianto <idiots718@gmail.com>

ENV BUILD_FLAG ${BUILD_FLAG} \
    NODE_PORT ${NODE_PORT}

WORKDIR /app/nuxt

COPY . ./

RUN apk add --no-cache git && \
    npm install && \
    npm install pm2@latest -g && \
    npm run build

EXPOSE ${NODE_PORT}

CMD [ "sh", "-c", "npm run start:$BUILD_FLAG" ]
