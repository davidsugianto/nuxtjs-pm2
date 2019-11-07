FROM node:10-alpine AS builder

LABEL maintainer idiots718 <idiots718@gmail.com>

WORKDIR /app

ENV NODE_ENV ${NODE_ENV} \
    PROJECT_DIR ${PROJECT_DIR} \
    NODE_PORT ${NODE_PORT} \
    BUILD_FLAG ${BUILD_FLAG} \
    SERVER_PATH_FILE ${SERVER_PATH_FILE} \
    APP_NAME ${APP_NAME}
ENV HOST 0.0.0.0

EXPOSE ${NODE_PORT}

RUN apk --no-cache update && \
    apk --no-cache upgrade && \
    apk --no-cache add tzdata

COPY ./scripts /scripts
RUN find /scripts -type f -iname "*.sh" -exec chmod a+x {} \;

ENTRYPOINT ["/scripts/entrypoint.sh"]

CMD [ "npm", "run", "start" ]

