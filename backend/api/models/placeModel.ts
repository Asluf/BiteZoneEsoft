import mongoose, { ObjectId } from "mongoose";
import { ObjectIdOr } from "../common/util";

export interface IPlace extends mongoose.Document {
    name: string;
    description: string;
    address: string;
    phone: string;
    latitude: number;
    longitude: number;
    images: string[];
    status: AvailableStatus;
    categories: FoodDrinkCategories[];
    city: string;
    updatedBy: mongoose.Types.ObjectId;
    isTrending: boolean;
}

export enum AvailableStatus {
    PENDING = "PENDING",
    AVAILABLE = "AVAILABLE",
    UNAVAILABLE = "UNAVAILABLE"
}

export enum FoodDrinkCategories {
    RESTAURANT = "RESTAURANT",
    CAFE = "CAFE",
    STREET_FOOD = "STREET_FOOD",
    BAR = "BAR",
    DESSERT = "DESSERT",
    BAKERY = "BAKERY",
    SEAFOOD = "SEAFOOD",
    LOCAL_CUISINE = "LOCAL_CUISINE",
    FAST_FOOD = "FAST_FOOD",
    HEALTHY_OPTION = "HEALTHY_OPTION",
};

