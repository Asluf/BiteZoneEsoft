import { Request, Response } from "express";
import User from "../schemas/userSchema";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import { Util } from "../common/util";
import mongoose from "mongoose";

export namespace PublicController {
  export async function signup(req: Request, res: Response): Promise<void> {
    try {
      const { name, email, password, role } = req.body;
      const hashedPassword = await bcrypt.hash(password, 12);
      const user = new User({ _id: new mongoose.Types.ObjectId(), name: name, email: email, password: hashedPassword, role: role });
      await user.save();
      Util.sendSuccess(res, "User created successfully");
    } catch (error) {
      throw Error(error);
    }
  };

  export async function login(req: Request, res: Response): Promise<void> {
    try {
      const { email, password } = req.body;
      const user = await User.findOne({ email });
      if (!user) {
        throw Error("User not found");
      }
      const isPasswordValid = await bcrypt.compare(password, user.password);
      if (!isPasswordValid) {
        throw Error("Invalid password");
      }
      const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET!);
      Util.sendSuccess(res, { token, _id: user._id, role: user.role, name: user.name, email: user.email });
    } catch (error) {
      throw Error(error);
    }
  };

  export async function logout(req: Request, res: Response): Promise<void> {
    try {
      Util.sendSuccess(res, "Logged out successfully");
    } catch (error) {
      Util.sendError(res, error);
    }
  };

  export async function test(req: Request, res: Response): Promise<void> {
    try {
      console.log('object')
      Util.sendSuccess(res, "test passed successfully");
    } catch (error) {
      Util.sendError(res, error);
    }

  };

}


