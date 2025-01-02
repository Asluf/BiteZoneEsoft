import mongoose, { Schema } from "mongoose";
import { IReview } from "../models/reviewModel";
import Place from "./placeSchema";
import User from "./userSchema";

const reviewSchema = new Schema<IReview>({
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
    rating: {
        type: Number,
        required: true,
        min: 1,
        max: 5,
    },
    message: {
        type: String,
        required: true,
    },
});

const Review = mongoose.model<IReview>("Review", reviewSchema);

export default Review;