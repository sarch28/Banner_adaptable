import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
    await MobileAds.instance.initialize();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.showBanner = true});

  final bool showBanner;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banner adaptable',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(
        title: 'Banner adaptable',
        showBanner: showBanner,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    this.showBanner = true,
  });

  final String title;
  final bool showBanner;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  BannerAd? _banner;
  bool _isBannerLoaded = false;
  int? _requestedWidth;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!widget.showBanner) return;

    final width = MediaQuery.sizeOf(context).width.truncate();
    if (width == _requestedWidth) return;

    _requestedWidth = width;
    _banner?.dispose();
    _banner = null;
    _isBannerLoaded = false;
    unawaited(_loadBanner(width));
  }

  Future<void> _loadBanner(int width) async {
    final adUnitId = switch (defaultTargetPlatform) {
      TargetPlatform.android => 'ca-app-pub-3940256099942544/6300978111',
      TargetPlatform.iOS => 'ca-app-pub-3940256099942544/2934735716',
      _ => null,
    };
    if (kIsWeb || adUnitId == null) return;

    final size = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(width);
    if (!mounted || _requestedWidth != width || size == null) return;

    late final BannerAd banner;
    banner = BannerAd(
      adUnitId: adUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted || !identical(_banner, banner)) {
            ad.dispose();
            return;
          }
          setState(() => _isBannerLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('No se pudo cargar el banner: $error');
          if (mounted && identical(_banner, banner)) {
            setState(() {
              _banner = null;
              _isBannerLoaded = false;
            });
          }
        },
      ),
    );
    _banner = banner;

    try {
      await banner.load();
    } catch (error, stackTrace) {
      banner.dispose();
      debugPrint('Error al solicitar el banner: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (mounted && identical(_banner, banner)) {
        setState(() {
          _banner = null;
          _isBannerLoaded = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _banner?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final banner = _banner;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('Veces que presionaste el botón:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      bottomNavigationBar: banner != null && _isBannerLoaded
          ? SafeArea(
              top: false,
              child: SizedBox(
                width: banner.size.width.toDouble(),
                height: banner.size.height.toDouble(),
                child: AdWidget(ad: banner),
              ),
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
