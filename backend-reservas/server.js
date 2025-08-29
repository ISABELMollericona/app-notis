import express from "express";
import mongoose from "mongoose";
import dotenv from "dotenv";
import cors from "cors";
import authRoutes from "./routes/auth.js";
import citasRoutes from "./routes/citas.js";

dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());

app.use("/api/auth", authRoutes);
app.use("/api/citas", citasRoutes);

mongoose.connect(process.env.MONGODB_URI)
  .then(() => {
    console.log("Mongo conectado");
    app.listen(process.env.PORT, () => console.log(`API en puerto ${process.env.PORT}`));
  })
  .catch(err => console.error("Error Mongo:", err));
