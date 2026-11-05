# ---------- Stage 1: build ----------
# Full dependency install (incl. TypeScript) to compile src/ -> dist/
FROM node:26-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --ignore-scripts
COPY tsconfig.json ./
COPY src ./src
RUN npm run build

# ---------- Stage 2: production dependencies ----------
# Runtime dependencies only (no TypeScript, vitest, etc.)
FROM node:26-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit=dev --ignore-scripts && npm cache clean --force

# ---------- Stage 3: runtime ----------
FROM node:26-alpine AS runtime
ENV NODE_ENV=production
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
COPY package.json ./
USER 1000:1000
EXPOSE 3000
CMD ["node", "dist/server.js"]