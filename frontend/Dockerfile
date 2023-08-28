FROM node:20 as build

WORKDIR /usr/src/app

COPY . .  

ENV NODE_OPTIONS=--openssl-legacy-provider
ENV NODE_ENV=/
ENV VUE_APP_API_URL=/
RUN npm install && npm run build

FROM nginx:1.25.1-alpine
ARG VERSION=${VERSION}
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/app/dist/ /usr/share/nginx/html/
