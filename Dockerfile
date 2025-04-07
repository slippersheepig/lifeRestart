FROM node:alpine AS builder
RUN apk add --no-cache git && npm install -g pnpm
RUN git clone https://github.com/VickScarlet/lifeRestart.git /lr
WORKDIR /lr
RUN pnpm install && pnpm xlsx2json
RUN pnpm run build

FROM node:alpine
RUN npm install -g pnpm
WORKDIR /usr/src/app
COPY --from=builder /lr .
CMD ["pnpm", "exec", "vite", "preview", "--host"]
