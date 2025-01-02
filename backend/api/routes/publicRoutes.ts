import { Express } from 'express';
import { Util } from "../common/util";
import { PublicController } from '../controllers/publicController';

export function initPublicRoutes(app: Express): void {
    app.post('/api/public/register', Util.withErrorHandling(PublicController.signup));
    app.post('/api/public/login', Util.withErrorHandling(PublicController.login));
    app.post('/api/public/logout', Util.withErrorHandling(PublicController.logout));
    app.get('/api/public/test', Util.withErrorHandling(PublicController.test));

}
