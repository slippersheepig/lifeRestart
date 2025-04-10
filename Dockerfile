FROM node:alpine AS builder
RUN apk add --no-cache git && npm install -g pnpm
RUN git clone https://github.com/VickScarlet/lifeRestart.git /lr
WORKDIR /lr
RUN pnpm install && pnpm xlsx2json
RUN pnpm run build

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /lr/template/public /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
