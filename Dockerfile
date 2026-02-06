# ---------- Stage 1: Build dependencies ----------
FROM node:18-alpine AS builder

WORKDIR /app

# Copy only dependency files first (layer caching)
COPY app/package*.json ./

# Install only production dependencies
RUN npm install 

# Copy app source (not repo root)
COPY app/. .

# ---------- Stage 2: Runtime image ----------
FROM node:18-alpine

WORKDIR /app

# Use non-root user (security best practice)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy built app from builder stage
COPY --from=builder /app /app

# Change ownership
RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 3000

CMD ["npm", "start"]
