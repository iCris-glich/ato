import 'package:creador_pdf/widget/aero_card.dart';
import 'package:creador_pdf/widget/barra_lateral.dart';
import 'package:creador_pdf/widget/custom_appBar.dart';
import 'package:creador_pdf/widget/custom_drawe.dart';
import 'package:creador_pdf/widget/formulario_carta_renuncia.dart';
import 'package:creador_pdf/widget/formulario_constancia_laboral.dart';
import 'package:flutter/material.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  bool mostrarBarra = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<String, List<Map<String, dynamic>>> cartas = {
    'Cartas': [
      {
        'titulo': 'Carta de renuncia',
        'action': (BuildContext context) {
          return showDialog(
            context: context,
            builder: (_) {
              return FormularioCartaRenuncia();
            },
          );
        },
      },
      {
        'titulo': 'Constancia laboral',
        'action': (BuildContext context) {
          return showDialog(
            context: context,
            builder: (_) {
              return FormularioConstanciaLaboral();
            },
          );
        },
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final anchoPantalla = MediaQuery.of(context).size.width;
    final alturaPantalla = MediaQuery.of(context).size.height;
    final listaCartas = cartas['Cartas']!;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: anchoPantalla <= 750 ? CustomDrawer() : null,
        appBar: CustomAppbar(),
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
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  anchoPantalla > 750
                      ? BarraLateral(
                          alturaPantalla: alturaPantalla,
                          anchoPantalla: anchoPantalla,
                        )
                      : SizedBox(
                          height: alturaPantalla,
                          child: IconButton(
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                  const SizedBox(width: 50),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: anchoPantalla > 750 ? 3 : 1,
                        crossAxisSpacing: 50,
                        mainAxisExtent: 250,
                        childAspectRatio: 1,
                      ),
                      itemCount: listaCartas.length,
                      itemBuilder: (context, index) {
                        final carta = listaCartas[index];

                        return AeroCard(
                          anchoPantalla: anchoPantalla,
                          alturaPantalla: alturaPantalla,
                          titulo: carta['titulo'],
                          onTap: () => carta['action'](context),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
