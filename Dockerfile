FROM node:18-alpine AS builder

WORKDIR /app

COPY app/package.json ./
RUN npm install

COPY app/ ./

RUN npm build

FROM node:18-alpine AS runner

WORKDIR /app

COPY --from=builder /app/package.json ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/public ./public

EXPOSE 3000

CMD ["npm", "start"]