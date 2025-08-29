import mongoose from "mongoose";

const CitaSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
  fecha: String,
  hora: String,
  motivo: String,
  timestamp: Date,
  notified: { type: Boolean, default: false }
}, { collection: "citas" });

export default mongoose.model("Cita", CitaSchema);
