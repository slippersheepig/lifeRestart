FROM alpine AS builder
RUN apk add --no-cache git
RUN git clone https://github.com/VickScarlet/lifeRestart.git /lr

FROM node:alpine
ENV NPM_CONFIG_LOGLEVEL info
WORKDIR /usr/src/app
COPY --from=builder /lr .
COPY package.json .
RUN npm install && npm run build
CMD ["npm", "start"]
