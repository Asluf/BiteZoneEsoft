import mongoose from "mongoose";

export interface IUser extends mongoose.Document {
  _id: mongoose.Types.ObjectId;
  name: string;
  role: UserRole;
  email: string;
  password: string;
  token?: string;
  age?: number;
  city?: string;
  address?: string;
  mobile?: string;  
}

export enum UserRole {
  SUPER_ADMIN = "SUPER_ADMIN",
  USER = "USER"
}
