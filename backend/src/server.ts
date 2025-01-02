import express, { Handler } from "express";
import mongoose from "mongoose";
import bodyParser from "body-parser";
import cors from "cors";
import dotenv from "dotenv";
import * as routes from "../api/routes/index";
import { Authentication } from "../api/middleware/authMiddleware";
import passport from "passport";

const app = express();
dotenv.config();

// app.use(
//   cors({
//     origin: "*",
//     credentials: true,
//   })
// );
app.use(
  cors({
    origin: "*",
  })
);
app.use(bodyParser.json());

app.use(express.json());

var port = process.env.PORT || 6000;

mongoose.set("strictQuery", true);
mongoose
  .connect(process.env.MONGODB_URI!)
  .then(() => console.log("Connected to Database"))
  .catch((error) => console.error("Database connection error:", error));

app.use(bodyParser.urlencoded({ extended: true }));

app.use(bodyParser.json());
app.use("/uploads", express.static("uploads"));

app.use("/api/auth", Authentication.verifyToken);

routes.initRoutes(app);

app.use(function (req, res) {
  res.status(404).send({ url: req.originalUrl + " not found" });
});

app.listen(port, () => {
  console.log(`Server started on: ${port}`);
});
