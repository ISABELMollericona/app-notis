import { Router } from "express";
import Cita from "../models/Cita.js";
import { auth } from "../middleware/auth.js";

const router = Router();

// Crear cita
router.post("/", auth, async (req, res) => {
  const { fecha, hora, motivo } = req.body;
  const timestamp = new Date(`${fecha}T${hora}:00`);
  const cita = await Cita.create({ userId: req.user.uid, fecha, hora, motivo, timestamp });
  res.json(cita);
});

// Historial
router.get("/mine", auth, async (req, res) => {
  const citas = await Cita.find({ userId: req.user.uid }).sort({ timestamp: -1 });
  res.json(citas);
});

export default router;
