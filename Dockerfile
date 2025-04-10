FROM nginx:alpine

RUN apk update && apk add --no-cache aws-cli