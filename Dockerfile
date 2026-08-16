FROM node:alpine AS builder
RUN apk add --no-cache git && npm install -g pnpm bun
RUN git clone --depth=1 https://github.com/VickScarlet/remake.git /lr
WORKDIR /lr
RUN pnpm install
RUN pnpm run build:data && pnpm run build:web

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /lr/apps/web/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
