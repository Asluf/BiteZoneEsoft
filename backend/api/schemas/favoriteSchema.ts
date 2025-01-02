import mongoose, { Schema } from "mongoose";
import { IFavorite } from "../models/favoriteModel";
import Place from "./placeSchema";
import User from "./userSchema";

const favoriteSchema = new Schema<IFavorite>({
    place: {
        type: mongoose.Types.ObjectId,
        ref: Place,
        required: true,
    },
    user: {
        type: mongoose.Types.ObjectId,
        ref: User,
        required: true,
    },
});

const Favorite = mongoose.model<IFavorite>("Favorite", favoriteSchema);

export default Favorite;