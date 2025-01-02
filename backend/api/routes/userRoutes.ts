import { Express } from 'express';
import multer from "multer";
import path from "path";
import { UserController } from '../controllers/userController';
import { Util } from '../common/util';

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, "uploads/place_images/");
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + path.extname(file.originalname));
    },
});
const upload = multer({ storage: storage });

export function initUserRoutes(app: Express): void {
    app.get("/api/auth/user/get-user-profile", Util.withErrorHandling(UserController.getUserProfile));
    app.put("/api/auth/user/update-user-profile", Util.withErrorHandling(UserController.updateUserProfile));
    
    app.post("/api/auth/user/add-place", upload.single("image"), Util.withErrorHandling(UserController.addPlace));
    app.get("/api/auth/user/get-all-places", Util.withErrorHandling(UserController.getAllPlaces));
    app.get("/api/auth/user/get-trending-places", Util.withErrorHandling(UserController.getTrendingPlaces));
    app.get("/api/auth/user/get-my-places", Util.withErrorHandling(UserController.getUserPlaces));
    
    // endpoints for favorites
    app.get("/api/auth/user/get-all-favorite-places", Util.withErrorHandling(UserController.getMyFavorites));
    app.post("/api/auth/user/add-favorite", Util.withErrorHandling(UserController.addFavorite));
    app.get("/api/auth/user/is-favorite", Util.withErrorHandling(UserController.isFavorite));

    // endpoints for reviews
    app.post("/api/auth/user/add-review", Util.withErrorHandling(UserController.addReview));
    app.get("/api/auth/user/get-reviews", Util.withErrorHandling(UserController.getReviews));
}