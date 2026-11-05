# AdSara: banner adaptable anclado

## Presentación

**Tipo de anuncio:** banner adaptable anclado (*large anchored adaptive
banner*).

Este formato muestra un anuncio rectangular fijo en el borde inferior de la
app. Google Mobile Ads calcula un tamaño adecuado según el ancho disponible y
la orientación del dispositivo. En esta demostración, el banner aparece en la
pantalla principal de AdSara cuando termina de cargar.

**Tecnologías:** Flutter, Dart y Google Mobile Ads Flutter Plugin.

## Referencias

- [Banners adaptables en Flutter](https://developers.google.com/admob/flutter/banner?hl=es)
- [Inicio rápido de Google Mobile Ads para Flutter](https://developers.google.com/admob/flutter/quick-start?hl=es)
- [Crear una cuenta de AdMob](https://support.google.com/admob/answer/7356219?hl=es)
- [Configurar una aplicación en AdMob](https://support.google.com/admob/answer/9989980?hl=es)
- [Buscar el ID de aplicación o de bloque de anuncios](https://support.google.com/admob/answer/7356431?hl=es)

## Demostración

**Capturas solicitadas:** agregar aquí capturas reales de AdSara ejecutándose
en un emulador o teléfono, incluyendo una donde se vea el banner de prueba.
Guárdalas en `docs/images/` y luego insértalas, por ejemplo:

```markdown
![AdSara con el banner adaptable visible](docs/images/adsara-banner.png)
```

Las capturas todavía están pendientes: no hay imágenes de la demostración
guardadas en este repositorio. Usa un anuncio de prueba de Google y no pulses
anuncios reales.

## Clonar el repositorio

```bash
git clone https://github.com/sarch28/banner_adaptable.git
cd banner_adaptable
```

El repositorio debe estar creado en GitHub y tener publicado el proyecto para
que otras personas puedan clonarlo. Si es privado, el usuario necesitará
permisos de acceso.

## Requisitos

- Flutter instalado y disponible en `PATH`.
- Android Studio y Android SDK configurados para ejecutar en Android.
- Un emulador Android iniciado o un teléfono conectado por USB con depuración
  USB habilitada y autorizado desde el dispositivo.
- Conexión a Internet para descargar dependencias y solicitar el anuncio de
  prueba.

Comprueba el entorno y los dispositivos disponibles:

```bash
flutter doctor
flutter devices
```

## Ejecutar en emulador o dispositivo Android

Desde la carpeta del proyecto, descarga las dependencias:

```bash
flutter pub get
```

Inicia la aplicación en el emulador o teléfono que aparezca en `flutter
devices`, sustituyendo `<ID_DEL_DISPOSITIVO>` por el ID mostrado:

```bash
flutter run -d <ID_DEL_DISPOSITIVO>
```

También puedes usar `flutter run` si solo hay un dispositivo conectado.
Cuando Android lo solicite, desbloquea el teléfono y autoriza la depuración o
instalación por USB. Para cerrar la ejecución desde la terminal, pulsa `q` o
`Ctrl+C`.

## Configuración de anuncios de prueba

Android usa el ID de aplicación de AdSara en
`android/app/src/main/AndroidManifest.xml`. El bloque de banner configurado en
`lib/main.dart` es el ID de prueba oficial de Google para Android:
`ca-app-pub-3940256099942544/6300978111`. iOS también conserva IDs de prueba.
Así se puede demostrar la integración sin solicitar anuncios reales; el banner
requiere conexión a Internet para cargar.

La cuenta de AdMob de AdSara aún puede estar pendiente de aprobación. Antes de
publicar, confirma el estado de la cuenta y la aplicación en AdMob y reemplaza
los IDs de prueba por los IDs de producción correspondientes. Nunca pulses tus
propios anuncios reales durante el desarrollo.

## Detalles de la implementación

1. Se agrega el paquete `google_mobile_ads`.
2. Se inicializa Google Mobile Ads al iniciar la app en Android o iOS.
3. Se obtiene el ancho disponible y se solicita el tamaño adaptable anclado
   con `AdSize.getLargeAnchoredAdaptiveBannerAdSize`.
4. Se crea y carga el `BannerAd`; el listener registra errores y actualiza la
   interfaz al cargar.
5. Se muestra el anuncio en `Scaffold.bottomNavigationBar`, dentro de
   `SafeArea` y `SizedBox`, y se libera con `dispose()`.
6. Se solicita un tamaño nuevo cuando cambia el ancho de la pantalla.
