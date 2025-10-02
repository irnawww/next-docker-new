# Challenge 2: Docker
## Task: Containerize a Next.js Web Application


---

## Kode Aplikasi  

**app/package.json**
```json
{
  "name": "docker-next-app",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start"
  },
  "dependencies": {
    "next": "latest",
    "react": "latest",
    "react-dom": "latest"
  }
}
```
**app/pages/index.js**
```
import React from 'react';

export default function HomePage() {
  return <h1>Hello, Docker!</h1>;
}
```

**Dockerfile**
```
FROM node:18-alpine AS builder

WORKDIR /app
COPY app/package.json ./
RUN npm install
COPY app/ ./
RUN npm run build

FROM node:18-alpine AS runner

WORKDIR /app
COPY --from=builder /app/package.json ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/public ./public

EXPOSE 3000
CMD ["npm", "start"]
```

**docker-compose.yml**
```
version: "3.8"
services:
  nextjs-app:
    build: .
    ports:
      - "3000:3000"
    restart: always
```

## Cara Menjalankan
### 1. Langsung build Docker image
```
docker-compose build
```
### 2. Jalankan container:
```
docker-compose up -d
```
### 3. Akses aplikasi melalui browseer
```
http://localhost:3000
```

## Output
### Jika berhasil dijalankan, aplikasi akan menampilkan halaman dengan tampilan berikut:






