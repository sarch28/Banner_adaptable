# Banner adaptable

Aplicación Flutter de ejemplo con un banner adaptable anclado al borde inferior
de la pantalla. El tamaño se calcula con el ancho disponible y se vuelve a
solicitar cuando cambia la orientación o el tamaño de la ventana.

## Ejecutar

```bash
flutter pub get
flutter run
```

## Crear una cuenta de AdMob y obtener los IDs

1. **Crear la cuenta.** Entra en [AdMob](https://admob.google.com/) con una
   cuenta de Google y sigue el registro. Selecciona con cuidado tu país o
   territorio, ya que no podrás cambiarlo después. Acepta los términos y
   completa la verificación telefónica si se solicita. Para verificar la
   cuenta, Google también puede pedirte datos de pago e identidad.

2. **Añadir cada plataforma como una aplicación.** En AdMob, abre
   **Aplicaciones > Añadir aplicación**, elige Android o iOS e indica si la app
   ya está publicada en una tienda admitida. Si aún no está publicada, puedes
   añadirla como aplicación sin publicar para hacer pruebas; vincúlala a la
   tienda cuando la publiques. AdMob puede limitar la publicación de anuncios
   hasta revisar y aprobar la aplicación. Android e iOS tienen registros e IDs
   de aplicación diferentes.

3. **Copiar el ID de aplicación.** En AdMob, abre **Aplicaciones**, selecciona
   la app y copia su **ID de aplicación**. Tiene un formato parecido a
   `ca-app-pub-XXXXXXXXXXXXXXXX~YYYYYYYYYY`. Configúralo en
   `android/app/src/main/AndroidManifest.xml` y/o `ios/Runner/Info.plist`,
   según la plataforma.

4. **Crear un bloque de anuncios de banner.** Dentro de la aplicación en
   AdMob, abre **Bloques de anuncios > Añadir bloque de anuncios**, selecciona
   **Banner**, asigna un nombre y crea el bloque. Copia el **ID del bloque de
   anuncios**, con un formato parecido a
   `ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY`. Crea y usa el bloque de la
   plataforma correspondiente; el tamaño adaptable se determina en el código
   Flutter, no al crear este bloque.

5. **Reemplazar los IDs de prueba.** En `main.dart`, sustituye los IDs de
   bloque de prueba por los IDs de banner de Android e iOS. Sustituye también
   los IDs de aplicación de prueba en el manifiesto Android y en `Info.plist`
   por los IDs que generó AdMob para cada aplicación. Mantén los IDs de prueba
   durante el desarrollo y no hagas clic en anuncios reales.

Consulta las guías oficiales: [registrarse en
AdMob](https://support.google.com/admob/answer/7356219?hl=es),
[configurar una aplicación](https://support.google.com/admob/answer/9989980?hl=es),
[buscar y copiar IDs](https://support.google.com/admob/answer/7356431?hl=es)
y [configurar banners adaptables en Flutter](https://developers.google.com/admob/flutter/banner?hl=es).

## Pasos de implementación

1. **Agregar el SDK de Google Mobile Ads.** La dependencia
   `google_mobile_ads` está declarada en `pubspec.yaml`. Para agregarla a otro
   proyecto, ejecuta:

   ```bash
   flutter pub add google_mobile_ads
   ```

2. **Inicializar el SDK.** En `main.dart`, inicializa Flutter y Google Mobile
   Ads antes de ejecutar la aplicación. La inicialización se limita a Android e
   iOS:

   ```dart
   WidgetsFlutterBinding.ensureInitialized();
   await MobileAds.instance.initialize();
   ```

3. **Configurar el identificador de aplicación de AdMob.** Agrega el
   identificador de aplicación de Android a
   `android/app/src/main/AndroidManifest.xml` y el de iOS a
   `ios/Runner/Info.plist`. Este proyecto ya tiene los identificadores de
   prueba oficiales de Google configurados en ambos archivos.

4. **Calcular el tamaño adaptable.** Obtén el ancho disponible en píxeles
   lógicos con `MediaQuery.sizeOf(context).width.truncate()` y solicita el
   tamaño adaptable anclado con
   `AdSize.getLargeAnchoredAdaptiveBannerAdSize(width)`. Si no se obtiene un
   tamaño, no se crea el anuncio.

5. **Crear y cargar el banner.** Crea un `BannerAd` con el tamaño calculado,
   el identificador de unidad correspondiente a la plataforma, una solicitud
   `AdRequest` y un `BannerAdListener`. El listener muestra el anuncio cuando
   carga y registra el error si falla.

6. **Mostrarlo anclado y liberar sus recursos.** Una vez cargado, inserta el
   `AdWidget` en `Scaffold.bottomNavigationBar`, envuelto en `SafeArea` y un
   `SizedBox` con las dimensiones del anuncio. Llama a `dispose()` cuando el
   anuncio deja de usarse o se destruye la pantalla.

7. **Actualizar el tamaño ante cambios de ventana.** Vuelve a solicitar el
   tamaño cuando cambie el ancho disponible, por ejemplo, al rotar el
   dispositivo. Descarta el anuncio anterior y evita aplicar resultados de
   solicitudes que ya no correspondan al ancho actual.

## Identificadores y pruebas

La aplicación usa identificadores de prueba de Google Mobile Ads para Android
e iOS. No uses anuncios reales durante el desarrollo. Antes de publicar,
reemplaza los identificadores de aplicación y de unidad de anuncio por los de
tu cuenta de AdMob.

El banner se muestra cuando termina de cargar. Si la carga falla, el error se
registra en la consola y la pantalla continúa funcionando sin el anuncio.
