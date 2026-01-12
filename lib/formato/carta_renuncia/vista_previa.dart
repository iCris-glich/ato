import 'dart:typed_data';
import 'dart:ui';

import 'package:creador_pdf/widget/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class VistaPrevia extends StatelessWidget {
  final Uint8List pdfBytes;

  const VistaPrevia({super.key, required this.pdfBytes});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppbar(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/fondo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFB3E5FC).withOpacity(0.45),
                        const Color(0xFF4FC3F7).withOpacity(0.35),
                        const Color(0xFF0288D1).withOpacity(0.25),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.7),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.35),
                        blurRadius: 14,
                        offset: const Offset(-2, -2),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 24,
                        offset: const Offset(0, 18),
                      ),
                    ],
                  ),
                  child: PdfPreview(
                    maxPageWidth: 520,
                    build: (_) async => pdfBytes,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
