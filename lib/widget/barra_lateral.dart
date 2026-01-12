import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BarraLateral extends StatelessWidget {
  final double alturaPantalla;
  final double anchoPantalla;

  const BarraLateral({
    super.key,
    required this.alturaPantalla,
    required this.anchoPantalla,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: anchoPantalla < 500 ? 1.5 : 3,
            sigmaY: anchoPantalla < 500 ? 1.5 : 3,
          ), // 🔥 optimizado
          child: Stack(
            children: [
              // Fondo principal
              Container(
                height: alturaPantalla,
                width: anchoPantalla * 0.21,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF0288D1).withOpacity(0.65),
                      const Color(0xFF1A237E).withOpacity(0.50),
                      const Color(0xFF455A64).withOpacity(0.45),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.30),
                      blurRadius: 8,
                      offset: const Offset(-2, -2),
                    ),
                  ],
                ),
              ),

              // GLOW INTERNO (clave Aero)
              // ─────────────────────────────
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1.2,
                      colors: [
                        Colors.white.withOpacity(0.35),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Contenido
              Padding(
                padding: const EdgeInsets.all(20),
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/img/logo.png',
                        height: 130,
                        width: anchoPantalla * 0.16,
                        fit: BoxFit.cover,
                      ),

                      SizedBox(height: 10),
                      _Item(
                        onTap: () => context.push('/historial'),
                        icono: Image.asset(
                          'assets/img/historial.png',
                          height: alturaPantalla * 0.05,
                          width: anchoPantalla * 0.05,
                        ),
                        titulo: 'Historial',
                      ),
                      const SizedBox(height: 15),
                      _Item(
                        onTap: () => context.push('/inicio'),
                        icono: Image.asset(
                          'assets/img/inicio.png',
                          height: alturaPantalla * 0.05,
                          width: anchoPantalla * 0.05,
                        ),
                        titulo: 'Inicio',
                      ),
                      Spacer(),
                      Text(
                        'Version Demo 1.0',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  final String titulo;
  final VoidCallback onTap;
  final Widget icono;

  const _Item({required this.titulo, required this.onTap, required this.icono});

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.titulo,
      button: true,
      child: RepaintBoundary(
        child: MouseRegion(
          onEnter: (_) => setState(() => _hover = true),
          onExit: (_) => setState(() {
            _hover = false;
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            transform: _hover
                // ignore: deprecated_member_use
                ? (Matrix4.identity()..scale(1.08))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: !_hover
                  ? Colors.transparent
                  : Colors.white.withOpacity(0.20),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                splashColor: Colors.cyanAccent.withOpacity(0.08),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      widget.icono,
                      const SizedBox(width: 10),
                      Text(
                        widget.titulo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
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
