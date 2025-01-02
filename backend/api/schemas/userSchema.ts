import mongoose, { Schema } from "mongoose";
import { IUser, UserRole } from "../models/userModel";

const userSchema = new Schema<IUser>({
  _id: {
    type: Schema.Types.ObjectId,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  role: {
    type: String,
    required: true,
    default: UserRole.USER
  },
  email: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    lowercase: true,
  },
  password: {
    type: String,
    required: true,
  },
  age: {
    type: Number,
    required: false,
  },
  city: {
    type: String,
    required: false,
  },
  address: {
    type: String,
    required: false,
  },
  mobile: {
    type: String,
    required: false,
  },
});

const User = mongoose.model<IUser>("User", userSchema);

export default User;
