import 'package:creador_pdf/goRouter.dart';
import 'package:creador_pdf/widget/tema.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      title: 'ATO',
      theme: frutigerAeroTheme,
    );
  }
}
