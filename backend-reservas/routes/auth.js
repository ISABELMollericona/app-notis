import { Router } from "express";
import jwt from "jsonwebtoken";
import bcrypt from "bcryptjs";
import User from "../models/User.js";

const router = Router();
const JWT_SECRET = process.env.JWT_SECRET;

// Registro
router.post("/register", async (req, res) => {
  const { nombre, email, password } = req.body;
  const hashed = await bcrypt.hash(password, 10);
  try {
    const user = await User.create({ nombre, email, password: hashed });
    res.json(user);
  } catch {
    res.status(400).json({ error: "Usuario ya existe" });
  }
});

// Login
router.post("/login", async (req, res) => {
  const { email, password } = req.body;
  const user = await User.findOne({ email });
  if (!user) return res.status(401).json({ error: "No existe el usuario" });

  const valid = await bcrypt.compare(password, user.password);
  if (!valid) return res.status(401).json({ error: "Contraseña incorrecta" });

  const token = jwt.sign({ uid: user._id, rol: user.rol }, JWT_SECRET, { expiresIn: "1d" });
  res.json({ token, user });
});

export default router;
