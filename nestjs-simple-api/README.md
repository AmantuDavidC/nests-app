# NestJS Simple API

A simple NestJS backend application for the Cloud Engineering team training exercise.

## Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/` | GET | Hello World message |
| `/health` | GET | Health check endpoint |
| `/about` | GET | API information |

## Getting Started

### Install dependencies
```bash
npm install
```

### Run in development mode
```bash
npm run start:dev
```

### Build for production
```bash
npm run build
```

### Run in production mode
```bash
npm run start:prod
```

## Testing the API

Once running, test the endpoints:

```bash
# Hello World
curl http://localhost:3000/

# Health Check
curl http://localhost:3000/health

# About
curl http://localhost:3000/about
```
