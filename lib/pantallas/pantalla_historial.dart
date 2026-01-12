import 'package:creador_pdf/servicio/servicio_historial.dart';
import 'package:creador_pdf/widget/barra_lateral.dart';
import 'package:flutter/material.dart';

Future<void> recibirfecha(String fecha) async {}

class PantallaHistorial extends StatelessWidget {
  const PantallaHistorial({super.key});

  @override
  Widget build(BuildContext context) {
    final anchoPantalla = MediaQuery.of(context).size.width;
    final alturaPantalla = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final historial = ServicioHistorial.instance.obtenerHistorial();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/fondo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.25)),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                anchoPantalla > 750
                    ? BarraLateral(
                        alturaPantalla: alturaPantalla,
                        anchoPantalla: anchoPantalla,
                      )
                    : IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                Expanded(
                  child: ListView.builder(
                    itemCount: historial.length,
                    itemBuilder: (context, index) {
                      final historia = historial[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(historia['documento'] ?? ''),
                              Row(
                                children: [
                                  Text(historia['fecha'] ?? ''),
                                  const SizedBox(width: 20),
                                  Text(historia['hora'] ?? ''),
                                  Spacer(),
                                  Text(historia['beneficiado'] ?? ''),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
