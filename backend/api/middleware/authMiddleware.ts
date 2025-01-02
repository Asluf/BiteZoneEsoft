// import jwt from "jsonwebtoken";
// import { Request, Response, NextFunction } from "express";
// import User from "../schemas/userSchema";

// // export const authenticateJWT = async (
// //   req: Request,
// //   res: Response,
// //   next: NextFunction
// // ) => {
// //   const token = req.header("Authorization")?.replace("Bearer ", "");
// //   if (!token) {
// //     console.log('no token');
// //     return res.status(401).send({
// //       success: false,
// //       error: "Access denied. No token provided.",
// //     });
// //   }

// //   try {
// //     const decodedUser: any = jwt.verify(token, process.env.JWT_SECRET!);
// //     const user = await User.findById(decodedUser.userId);


// //     if (!user) {
// //       return res.status(401).send({ success: false, error: "Invalid token." });
// //     }

// //     req.user = user;
// //     next();
// //   } catch (ex) {
// //     console.log('exception:', ex);
// //     return res.status(401).send({ success: false, error: "Invalid token." });
// //   }
// // };


import passport from 'passport';
import { ExtractJwt, Strategy as JwtStrategy } from 'passport-jwt';
import { Request, Response, NextFunction } from 'express';
import { Util } from '../common/util';
import User from '../schemas/userSchema';

const opts = {
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    secretOrKey: "BiteZoneBackendSecret",
};

passport.use(
    new JwtStrategy(opts, async (jwt_payload, done) => {
        try {
            const user = await User.findById(jwt_payload.userId); 
            if (user) {
                return done(null, user);
            } else {
                return done(null, false);
            }
        } catch (err) {
            return done(err, false);
        }
    })
);

export class Authentication {
    public static verifyToken(req: Request, res: Response, next: NextFunction) {
        return passport.authenticate('jwt', { session: false }, (err: any, user: any, info: any) => {
            if (err || !user) {
                console.log('No user found')
                return Util.sendError(res, info);
            }
            req.user = user;
            return next();
        })(req, res, next);
    }
}

