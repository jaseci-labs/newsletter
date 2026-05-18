# syntax=docker/dockerfile:1.7

# ----- build stage (uses Bun for fast, lockfile-aware install) -----
FROM oven/bun:1.3-alpine AS build
WORKDIR /app

# Install dependencies first to leverage layer caching.
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

# Copy source and build.
COPY . .
RUN bun run build

# ----- runtime stage (Node — Astro's Node adapter targets Node) -----
FROM node:22-alpine AS runtime
WORKDIR /app

ENV NODE_ENV=production \
    HOST=0.0.0.0 \
    PORT=4321

# Copy the production server output and node_modules from the build stage.
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./package.json

# Run as non-root.
USER node

EXPOSE 4321

CMD ["node", "./dist/server/entry.mjs"]
