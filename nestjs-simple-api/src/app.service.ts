import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World! Welcome to the CE Team Training API 🎉';
  }

  getHealthCheck(): object {
    return {
      status: 'healthy',
      timestamp: new Date().toISOString(),
      uptime: process.uptime(),
      service: 'nestjs-simple-api',
      version: '1.0.0',
    };
  }

  getAbout(): object {
    return {
      name: 'CE Team Training API',
      description: 'A simple NestJS backend for learning CI/CD and deployment',
      author: 'Cloud Engineering Team',
      endpoints: [
        { path: '/', method: 'GET', description: 'Hello World message' },
        { path: '/health', method: 'GET', description: 'Health check endpoint' },
        { path: '/about', method: 'GET', description: 'API information' },
      ],
    };
  }
}
