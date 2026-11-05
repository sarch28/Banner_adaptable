# AdSara: banner adaptable anclado

## Presentación

**Tipo de anuncio:** banner adaptable anclado (*large anchored adaptive
banner*).

Este formato muestra un anuncio rectangular fijo en el borde inferior de la
app. Google Mobile Ads calcula un tamaño adecuado según el ancho disponible y
la orientación del dispositivo. La demo muestra el banner en la pantalla
principal cuando el anuncio termina de cargar.

**Tecnologías:** Flutter, Dart y Google Mobile Ads Flutter Plugin.

## Referencias

- [Banners adaptables en Flutter](https://developers.google.com/admob/flutter/banner?hl=es)
- [Inicio rápido de Google Mobile Ads para Flutter](https://developers.google.com/admob/flutter/quick-start?hl=es)
- [Crear una cuenta de AdMob](https://support.google.com/admob/answer/7356219?hl=es)
- [Configurar una aplicación en AdMob](https://support.google.com/admob/answer/9989980?hl=es)
- [Buscar el ID de aplicación o de bloque de anuncios](https://support.google.com/admob/answer/7356431?hl=es)

## Clonar el proyecto

No es necesario tener una cuenta de AdMob para ejecutar la demostración: el
proyecto usa un ID de bloque de anuncios de prueba de Google.

Instala Git y Flutter en tu laptop. En Windows, instala también Android Studio
y el Android SDK. Después, abre PowerShell o una terminal y ejecuta:

```powershell
git clone https://github.com/sarch28/Banner_adaptable.git
cd Banner_adaptable
flutter doctor
flutter pub get
```

Si `flutter doctor` muestra licencias de Android pendientes, acepta las
licencias con:

```powershell
flutter doctor --android-licenses
```

El aviso sobre Visual Studio solo es necesario para compilar apps de Windows;
no se necesita para ejecutar esta app en Android.

## Ejecutar en un emulador Android

1. Abre Android Studio y entra en **Device Manager**.
2. Crea un dispositivo virtual con una imagen de Android que incluya Google
   Play; inicia el emulador y espera a que termine de arrancar.
3. En la terminal, desde la carpeta `Banner_adaptable`, lista los dispositivos
   y ejecuta la app:

   ```powershell
   flutter devices
   flutter run -d <ID_DEL_EMULADOR>
   ```

Reemplaza `<ID_DEL_EMULADOR>` por el ID que muestra `flutter devices`
(normalmente empieza con `emulator-`). Si solo hay un dispositivo conectado,
puedes usar:

```powershell
flutter run
```

## Ejecutar en un teléfono Android

1. Activa las **Opciones de desarrollador** y la **Depuración USB** del
   teléfono.
2. Conéctalo a la laptop con un cable USB que transfiera datos, desbloquéalo
   y acepta el aviso **¿Permitir depuración USB?**.
3. En algunos teléfonos Xiaomi también debes habilitar **Instalar vía USB** en
   las Opciones de desarrollador.
4. Comprueba que Flutter detecte el teléfono y ejecuta la app:

   ```powershell
   flutter devices
   flutter run -d <ID_DEL_TELEFONO>
   ```

Reemplaza `<ID_DEL_TELEFONO>` por el ID que aparece junto al teléfono. Cuando
Android pregunte si permites la instalación, acéptala. Para cerrar la ejecución
desde la terminal, pulsa `q` o `Ctrl+C`.

## Anuncios de prueba

Android usa el ID de aplicación de AdSara configurado en
`android/app/src/main/AndroidManifest.xml` y el ID de banner de prueba de Google
configurado en `lib/main.dart`. iOS conserva IDs de prueba de Google. No hace
falta crear una cuenta ni registrar la app en AdMob para ejecutar el proyecto.

El banner necesita conexión a Internet y Google Play Services actualizado. Si
no aparece, revisa la salida de `flutter run` y comprueba la conexión. Un error
de red puede impedir que cargue el anuncio aunque la app abra correctamente.
El banner de prueba puede mostrar contenido marcado como anuncio de prueba.
Nunca hagas clic en anuncios reales durante el desarrollo.

Para usar anuncios propios en una publicación, cada desarrollador debe
configurar sus IDs de aplicación y de bloque de anuncios de AdMob, y confirmar
que la cuenta y la aplicación estén aprobadas.

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
