"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AppService = void 0;
const common_1 = require("@nestjs/common");
let AppService = class AppService {
    getHello() {
        return 'Hello World! Welcome to the CE Team Training API 🎉';
    }
    getHealthCheck() {
        return {
            status: 'healthy',
            timestamp: new Date().toISOString(),
            uptime: process.uptime(),
            service: 'nestjs-simple-api',
            version: '1.0.0',
        };
    }
    getAbout() {
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
};
exports.AppService = AppService;
exports.AppService = AppService = __decorate([
    (0, common_1.Injectable)()
], AppService);
//# sourceMappingURL=app.service.js.map