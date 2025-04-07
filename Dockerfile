FROM node:alpine AS builder
RUN apk add --no-cache git && npm install -g pnpm
RUN git clone https://github.com/VickScarlet/lifeRestart.git /lr
WORKDIR /lr
RUN pnpm install && pnpm xlsx2json
RUN pnpm run build

FROM nginx:alpine-slim
COPY --from=builder /lr/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
