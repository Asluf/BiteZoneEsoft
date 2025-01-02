import mongoose from "mongoose";
import { ObjectIdOr } from "../common/util";
import { IPlace } from "./placeModel";
import { IUser } from "./userModel";

export interface IReview extends mongoose.Document {
    place: ObjectIdOr<IPlace>;
    user: ObjectIdOr<IUser>;
    rating: number;
    message: string;
}