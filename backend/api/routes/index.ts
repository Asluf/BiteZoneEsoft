import { Express, Request, Response } from "express";
import { initPublicRoutes } from "./publicRoutes";
import { Util } from "../common/util";
import { initAdminRoutes } from "./adminRoutes";
import { initUserRoutes } from "./userRoutes";


export function initRoutes(app: Express) {
    /* TOP LEVEL */
    app.get('/api', (req: Request, res: Response) => Util.sendSuccess(res, "Example™ Api"));

    initPublicRoutes(app);
    initAdminRoutes(app);
    initUserRoutes(app);

    /* ALL INVALID REQUESTS */
    app.all('*', (req: Request, res: Response) => Util.sendError(res, "Route Not Found"));
}
