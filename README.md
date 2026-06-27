<<<<<<< HEAD
# INFLECTION

Plataforma interactiva de psicología, neurociencia y desarrollo personal enfocada en
autonomía, soberanía individual y optimización conductual.

- **Stack:** Flutter + Dart, Riverpod (gestión de estado), go_router (navegación).
- **Arquitectura:** feature-first por capas (Data / Domain / Presentation).
- **Estética:** Dark mode estricto (`#000000`), minimalista y tecnológica.

## Estructura

```
lib/
├── main.dart                  # entrypoint + ProviderScope
├── app.dart                   # MaterialApp.router, dark estricto
├── core/
│   ├── theme/app_theme.dart   # negro absoluto + paleta del Orbe + ColorScheme
│   └── router/app_router.dart # rutas + transiciones custom
└── features/
    ├── splash/                # bienvenida con Orbe -> auto-transición al dashboard
    ├── home/                  # Orbe interactivo (entrada alternativa en /home)
    ├── dashboard/             # panel con los 3 pilares
    └── neuroscience/          # lista de módulos (mock) + detalle
```

## Flujo

`Splash (/) → [3s] → Dashboard → Módulos de Neurociencia → Detalle`

---

## Opción A — GitHub Codespaces (demo en el navegador)

1. Subí este proyecto a un repo de GitHub.
2. En el repo: **Code → Codespaces → Create codespace on main**.
3. El devcontainer instala Flutter y corre `scripts/setup.sh` solo.
4. Cuando termine, en la terminal del Codespace:

   ```bash
   flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0
   ```

5. Abrí la pestaña **Puertos** (Ports) → puerto **8080** → "Abrir en el navegador".

## Opción B — Local (Windows)

1. Instalá el SDK de Flutter: https://docs.flutter.dev/get-started/install/windows
2. En esta carpeta:

   ```powershell
   flutter create . --project-name inflection
   flutter pub get
   flutter run -d chrome        # o el dispositivo/emulador que prefieras
   ```

> Nota: `flutter create .` regenera las carpetas de plataforma. Si te sobreescribe
> algún archivo de `lib/`, restaurá desde git. En Codespaces esto lo maneja
> `scripts/setup.sh`, que preserva `lib/` y `pubspec.yaml`.
=======
# inflection
Sistema de gestión para el estudio y aplicación del desarrollo humano.
>>>>>>> f3c1e445f34e1aac0765bd05ce94ff3ba1097056
