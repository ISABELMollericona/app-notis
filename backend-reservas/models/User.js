import mongoose from "mongoose";

const UserSchema = new mongoose.Schema({
  nombre: String,
  email: { type: String, unique: true },
  password: String,
  rol: { type: String, default: "user" },
  fcmTokens: { type: [String], default: [] }
}, { collection: "usuarios" });

export default mongoose.model("User", UserSchema);
