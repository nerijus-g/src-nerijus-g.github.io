FROM --platform=$BUILDPLATFORM node:bullseye-slim

WORKDIR /app

RUN npm install -g @angular/cli

EXPOSE 4200