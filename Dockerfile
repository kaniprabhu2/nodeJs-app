FROM node:18-alpine

WORKDIR /app

COPY package.json package.json
RUN npm install

COPY . .

EXPOSE 5000

# Install curl (needed for HEALTHCHECK)
RUN apk add --no-cache curl

# Health check (correct port)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s \
CMD curl -f http://localhost:5000/health || exit 1

CMD ["node", "app.js"]
