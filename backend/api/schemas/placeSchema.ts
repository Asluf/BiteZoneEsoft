import mongoose, { Schema } from "mongoose";
import { IPlace, AvailableStatus, FoodDrinkCategories } from "../models/placeModel";
import User from "./userSchema";

const placeSchema = new Schema<IPlace>({
    name: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    address: {
        type: String,
        required: true,
    },
    phone: {
        type: String,
        required: true,
    },
    latitude: {
        type: Number,
        required: true,
    },
    longitude: {
        type: Number,
        required: true,
    },
    images: {
        type: [String],
        required: true,
    },
    status: {
        type: String,
        enum: AvailableStatus,
        default: AvailableStatus.PENDING,
        required: true,
    },
    categories: {
        type: [String],
        enum: FoodDrinkCategories,
        required: true,
    },
    city: {
        type: String,
        required: true,
    },
    updatedBy: {
        type: Schema.Types.ObjectId,
        default: null,
        required: true,
        ref: User,
    },
    isTrending: {
        type: Boolean,
        default: false,
        required: true,
    },
});

const Place = mongoose.model<IPlace>("place", placeSchema);

export default Place;