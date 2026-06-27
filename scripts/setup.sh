#!/usr/bin/env bash
# Prepara el proyecto: genera el scaffolding de plataformas (que NO está en el
# repo) sin tocar nuestro lib/ ni pubspec.yaml, y descarga dependencias.
set -euo pipefail

echo "==> Verificando Flutter..."
flutter --version

# Si faltan las carpetas de plataforma, las generamos en un temporal
# y copiamos SOLO lo que no tenemos (web/android), preservando nuestro código.
if [ ! -d "web" ] || [ ! -d "android" ]; then
  echo "==> Generando scaffolding de plataformas (web, android)..."
  TMP="$(mktemp -d)"
  flutter create --project-name inflection --platforms=web,android "$TMP" >/dev/null
  [ -d "web" ]     || cp -r "$TMP/web" ./web
  [ -d "android" ] || cp -r "$TMP/android" ./android
  [ -f ".metadata" ] || cp "$TMP/.metadata" ./.metadata
  rm -rf "$TMP"
fi

echo "==> Descargando dependencias..."
flutter pub get

echo ""
echo "================================================================"
echo " LISTO. Para ver el demo en el navegador (pestaña 'Puertos'):"
echo ""
echo "   flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0"
echo ""
echo "================================================================"
