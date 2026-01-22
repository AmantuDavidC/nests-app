git rm -r --cached nestjs-simple-api zimport { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('health')
  getHealth(): object {
    return this.appService.getHealthCheck();
  }

  @Get('about')
  getAbout(): object {
    return this.appService.getAbout();
  }
}
