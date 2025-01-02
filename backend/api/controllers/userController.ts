import { Request, Response } from "express";
import User from "../schemas/userSchema";
import Place from "../schemas/placeSchema";
import { Util } from "../common/util";
import { IUser } from "../models/userModel";
import Favorite from "../schemas/favoriteSchema";
import { AvailableStatus } from "../models/placeModel";
import Review from "../schemas/reviewSchama";

export namespace UserController {
    export async function getUserProfile(req: Request, res: Response): Promise<void> {
        try {
            const user = req.user;
            if (!user) {
                throw Error("User not authenticated");
            }
            Util.sendSuccess(res, user);
        } catch (error) {
            throw Error(error);
        }
    };

    export async function updateUserProfile(req: Request, res: Response): Promise<void> {
        try {
            const currentUser = req.user as IUser;
            const user = await User.findById(currentUser?._id);
            if (!user) {
                throw Error("User not authenticated");
            }

            const { name, age, city, address, mobile } = req.body;

            user.set({
                name: name || user.name,
                age: age || user.age,
                city: city || user.city,
                address: address || user.address,
                mobile: mobile || user.mobile,
            });

            await user.save();
            Util.sendSuccess(res, user, "Profile updated successfully");
        } catch (error) {
            throw Error(error);
        }
    };

    export async function addPlace(req: Request, res: Response): Promise<void> {
        // try {
        //     const currentUser = req.user as IUser;
        //     const { description, location } = req.body;
        //     const reqPersonId = currentUser?._id;
        //     const image = req.file ? req.file.filename : null;

        //     if (!description || !location || !image) {
        //         throw Error("All fields are required");
        //     }

        //     const report = new Place({
        //         description,
        //         location,
        //         image,
        //         status: "REQUESTED",
        //         reqPersonId,
        //     });

        //     await report.save();
        //     Util.sendSuccess(res, report, "Report created successfully");
        // } catch (error) {
        //     throw Error(error);
        // }
    };

    export async function getAllPlaces(req: Request, res: Response): Promise<void> {
        try {
            const search = req.query.search as string;
            const city = req.query.city as string;
            const query: any = { status: AvailableStatus.AVAILABLE };

            if (search) {
                query.$or = [
                    { name: { $regex: search, $options: "i" } },
                    { categories: { $in: [new RegExp(search, "i")] } },
                ];
            }

            if (city) {
                query.city = { $regex: city, $options: "i" };
            }

            const data = await Place.find(query).populate({
                path: 'updatedBy',
                select: 'name'
            });
            Util.sendSuccess(res, data);
        } catch (error) {
            throw Error(error);
        }
    }

    export async function getTrendingPlaces(req: Request, res: Response): Promise<void> {
        try {
            const data = await Place.find({ status: AvailableStatus.AVAILABLE, isTrending: true }).populate({
                path: 'updatedBy',
                select: 'name'
            });
            Util.sendSuccess(res, data);
        } catch (error) {
            throw Error(error);
        }
    }

    export async function getUserPlaces(req: Request, res: Response): Promise<void> {
        try {
            const currentUser = req.user as IUser;
            const places = await Place.find({ updatedBy: currentUser?._id });
            Util.sendSuccess(res, places);
        } catch (error) {
            throw Error(error);
        }
    };

    export async function getMyFavorites(req: Request, res: Response): Promise<void> {
        try {
            const currentUser = req.user as IUser;
            const favorites = await Favorite.find({ user: currentUser?._id }).populate({
                path: 'place',
                populate: {
                    path: 'updatedBy',
                    select: 'name'
                }
            });

            const data = favorites.map(favorite => favorite.place);
            Util.sendSuccess(res, data);
        } catch (error) {
            throw Error(error);
        }
    }

    export async function addFavorite(req: Request, res: Response): Promise<void> {
        try {
            const currentUser = req.user as IUser;
            const { placeId } = req.body;

            const existingFavorite = await Favorite.findOne({ user: currentUser?._id, place: placeId });

            if (existingFavorite) {
                await Favorite.deleteOne({ _id: existingFavorite._id });
                Util.sendSuccess(res, null, "Place removed from favorites successfully");
            } else {
                const favorite = new Favorite({
                    user: currentUser?._id,
                    place: placeId,
                });

                await favorite.save();
                Util.sendSuccess(res, favorite, "Place added to favorites successfully");
            }
        } catch (error) {
            throw Error(error);
        }
    }

    export async function isFavorite(req: Request, res: Response): Promise<void> {
        try {
            const currentUser = req.user as IUser;
            const { placeId } = req.query;

            const favorite = await Favorite.findOne({ user: currentUser?._id, place: placeId });

            if (favorite) {
                Util.sendSuccess(res, true, "Place is a favorite");
            } else {
                Util.sendSuccess(res, false, "Place is not a favorite");
            }
        } catch (error) {
            throw Error(error);
        }
    }

    export async function addReview(req: Request, res: Response): Promise<void> {
        try {
            const currentUser = req.user as IUser;
            const { placeId, rating, message } = req.body;

            const review = new Review({
                place: placeId,
                user: currentUser?._id,
                rating,
                message,
            });

            await review.save();
            Util.sendSuccess(res, review, "Review added successfully");
        } catch (error) {
            throw Error(error);
        }
    }

    export async function getReviews(req: Request, res: Response): Promise<void> {
        try {
            const { placeId } = req.query;

            const reviews = await Review.find({ place: placeId }).populate({
                path: 'user',
                select: 'name'
            });

            Util.sendSuccess(res, reviews);
        } catch (error) {
            throw Error(error);
        }
    }
}



