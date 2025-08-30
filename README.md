
# Sistema de Reservas - Frontend y Backend

Este proyecto está compuesto por dos partes:
- **Frontend:** Aplicación Flutter (`app_reservas`)
- **Backend:** API Node.js (`backend-reservas`)

---

## Frontend: app_reservas (Flutter)

### Instalación y ejecución
1. Instala Flutter: [Flutter Install](https://docs.flutter.dev/get-started/install)
2. Ve a la carpeta del proyecto:
	```powershell
	cd app_reservas
	flutter pub get
	flutter run
	```
3. Para generar el APK debug:
	```powershell
	flutter build apk --debug
	```

### Principales dependencias
- `firebase_core`, `firebase_messaging`: Notificaciones push
- `flutter_local_notifications`: Notificaciones locales
- `http`, `intl`, `timezone`

### Configuración Firebase
Coloca tu archivo `google-services.json` en `android/app/`.

---

## Backend: backend-reservas (Node.js)

### Instalación y ejecución
1. Ve a la carpeta del backend:
	```powershell
	cd backend-reservas
	npm install
	node server.js
	```

### Principales dependencias
- `express`: Framework para API REST
- `mongoose`: Conexión a MongoDB

### Estructura de carpetas
- `models/`: Modelos de datos (`User.js`, `Cita.js`)
- `routes/`: Rutas de la API (`auth.js`, `citas.js`)
- `middleware/`: Autenticación

---

## Comunicación Frontend <-> Backend
El frontend realiza peticiones HTTP al backend para crear y consultar citas.

---

## Notas
- Configura correctamente las variables de entorno y credenciales de Firebase/MongoDB.
- Para enviar correos electrónicos puedes integrar la API de Gmail en el backend.

---

## Recursos útiles
- [Documentación Flutter](https://docs.flutter.dev/)
- [Documentación Node.js](https://nodejs.org/es/docs/)
- [Documentación Firebase](https://firebase.google.com/docs)
