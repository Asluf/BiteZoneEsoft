import mongoose from "mongoose";
import { ObjectIdOr } from "../common/util";
import { IPlace } from "./placeModel";
import { IUser } from "./userModel";

export interface IFavorite extends mongoose.Document {
    _id?: mongoose.Types.ObjectId;
    place: ObjectIdOr<IPlace>;
    user: ObjectIdOr<IUser>;
}