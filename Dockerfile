# Use Node.js for building and serving
FROM node:20-slim AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy source files
COPY . .

# Build the frontend assets
RUN npm run build

# Compile the TypeScript server to JavaScript for production
RUN npx tsc server.ts --outDir /app/dist --module ES2022 --target ES2022 --moduleResolution bundler --noEmit false

# Final runtime image
FROM node:20-slim AS runner
WORKDIR /app
ENV NODE_ENV=production

# Copy built frontend and compiled server
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

# Install only production dependencies
RUN npm install --omit=dev

# Expose the application port used by the server
EXPOSE 3000

# Start the compiled server
CMD ["node", "dist/server.js"]
