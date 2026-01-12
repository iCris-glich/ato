import 'dart:ui';
import 'package:flutter/material.dart';

class AeroCard extends StatefulWidget {
  final String titulo;
  final VoidCallback onTap;
  final double alturaPantalla;
  final double anchoPantalla;

  const AeroCard({
    super.key,
    required this.titulo,
    required this.onTap,
    required this.alturaPantalla,
    required this.anchoPantalla,
  });

  @override
  State<AeroCard> createState() => _AeroCardState();
}

class _AeroCardState extends State<AeroCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.titulo,
      child: RepaintBoundary(
        child: MouseRegion(
          onEnter: (_) => setState(() => _hover = true),
          onExit: (_) => setState(() => _hover = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            transform: _hover
                ? (Matrix4.identity()..scale(1.035))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withOpacity(_hover ? 0.65 : 0.35),
                  blurRadius: _hover ? 22 : 14,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: widget.onTap,
              child: _buildGlass(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlass() {
    final altura = widget.alturaPantalla;
    final ancho = widget.anchoPantalla;

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        children: [
          // ─────────────────────────────
          // BLUR (vidrio real)
          // ─────────────────────────────
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(),
          ),

          // ─────────────────────────────
          // CUERPO DEL VIDRIO
          // ─────────────────────────────
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _hover
                    ? [
                        const Color(0xFF26A69A).withOpacity(0.65),
                        const Color(0xFF006064).withOpacity(0.50),
                        const Color(0xFF37474F).withOpacity(0.45),
                      ]
                    : [
                        const Color(0xFF0288D1).withOpacity(0.65),
                        const Color(0xFF1A237E).withOpacity(0.50),
                        const Color(0xFF455A64).withOpacity(0.45),
                      ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(_hover ? 0.5 : 0.3),
                width: _hover ? 1.8 : 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.28),
                  blurRadius: 8,
                  offset: const Offset(-2, -2),
                ),
              ],
            ),
          ),

          // ─────────────────────────────
          // GLOW INTERNO (clave Aero)
          // ─────────────────────────────
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.2,
                  colors: [Colors.white.withOpacity(0.35), Colors.transparent],
                ),
              ),
            ),
          ),

          // ─────────────────────────────
          // CONTENIDO
          // ─────────────────────────────
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Image.asset(
                  'assets/img/documento.png',
                  height: altura * 0.112,
                  width: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
