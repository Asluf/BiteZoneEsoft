import { NextFunction, Request, Response } from "express";
import mongoose from "mongoose";

export type ObjectIdOr<T extends mongoose.Document> = mongoose.Types.ObjectId | T;

export type StringOrObjectId = string | mongoose.Types.ObjectId;

export type ObjectId = mongoose.Types.ObjectId;
export namespace Util {

    export function sendSuccess(res: Response, data: any, message: string = null): void {
        res.send({ success: true, data, message });
    }

    export function sendError(res: Response, error: any, errorCode = 0): void {
        if (typeof error === 'string') {
            res.send({ success: false, error, errorCode });
        } else {
            if (!error) {
                error = { stack: null, message: "Unknown Error" };
            }
            res.send({ success: false, error: error.message, errorData: error, errorCode });
        }
    }

    export function withErrorHandling(requestHandler: (req: Request, res: Response, next: NextFunction) => Promise<any>) {
        return function (req: Request, res: Response, next: NextFunction) {
            requestHandler(req, res, next).catch(next);
        };
    }
}
