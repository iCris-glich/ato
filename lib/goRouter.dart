import 'dart:typed_data';

import 'package:creador_pdf/formato/carta_renuncia/vista_previa.dart';
import 'package:creador_pdf/pantallas/pantalla_historial.dart';
import 'package:creador_pdf/pantallas/pantalla_incio.dart';
import 'package:creador_pdf/pantallas/pantalla_splash.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/inicio', builder: (context, state) => PantallaInicio()),
    GoRoute(
      path: '/vista_previa',
      builder: (context, state) {
        final pdfBytes = state.extra as Uint8List;
        return VistaPrevia(pdfBytes: pdfBytes);
      },
    ),
    GoRoute(
      path: '/historial',
      builder: (context, state) => PantallaHistorial(),
    ),
  ],
);
