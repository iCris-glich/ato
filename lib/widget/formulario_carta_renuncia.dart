import 'package:creador_pdf/formato/carta_renuncia/formato_carta_renuncia.dart';
import 'package:creador_pdf/servicio/servicio_historial.dart';
import 'package:creador_pdf/widget/boton_aeros.dart';
import 'package:creador_pdf/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';

class FormularioCartaRenuncia extends StatefulWidget {
  const FormularioCartaRenuncia({super.key});

  @override
  State<StatefulWidget> createState() {
    return FormularioCartaRenunciaState();
  }
}

class FormularioCartaRenunciaState extends State<FormularioCartaRenuncia> {
  final _empleado = TextEditingController();
  final _patrono = TextEditingController();
  final _rrhh = TextEditingController();
  final _cargo = TextEditingController();
  final _cargoRrhh = TextEditingController();
  final _lugar = TextEditingController();
  final _empresa = TextEditingController();

  @override
  void dispose() {
    _empleado.dispose();
    _patrono.dispose();
    _rrhh.dispose();
    _cargo.dispose();
    _cargoRrhh.dispose();
    _lugar.dispose();
    _empresa.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Llena las casilla para generar tu carta de renuncia'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextfield(
            controller: _empleado,
            texto: 'Tu nombre',
            icono: Icon(Icons.person),
          ),
          const SizedBox(height: 10),
          CustomTextfield(
            controller: _cargo,
            texto: 'Tu puesto',
            icono: Icon(Icons.person),
          ),
          const SizedBox(height: 10),
          CustomTextfield(
            controller: _lugar,
            texto: 'Direccion donde trabajabas',
            icono: Icon(Icons.person),
          ),
          const SizedBox(height: 10),
          CustomTextfield(
            controller: _patrono,
            texto: 'Nombre de patrono/jefe',
            icono: Icon(Icons.person),
          ),
          const SizedBox(height: 10),
          CustomTextfield(
            controller: _rrhh,
            texto: 'Nombre de encargado de RRHH',
            icono: Icon(Icons.person),
          ),
          const SizedBox(height: 10),
          CustomTextfield(
            controller: _cargoRrhh,
            texto: 'Cargo/Titulo de RRHH',
            icono: Icon(Icons.person),
          ),
          const SizedBox(height: 10),
          CustomTextfield(
            controller: _empresa,
            texto: 'Nombre de la empresa',
            icono: Icon(Icons.person),
          ),
        ],
      ),
      actions: [
        AeroButton(
          onPressed: () async {
            final ahora = DateTime.now();
            final fecha =
                '${ahora.day.toString().padLeft(2, '0')}/'
                '${ahora.month.toString().padLeft(2, '0')}/'
                '${ahora.year}';

            final hora =
                '${ahora.hour.toString().padLeft(2, '0')}:${ahora.minute.toString().padLeft(2, '0')}';

            ServicioHistorial.instance.agregarRegistro(
              documento: 'Carta de renuncia',
              fecha: fecha,
              hora: hora,
              beneficiado: _empleado.text,
            );

            final pdfBytes = await crearCartaRenuncia(
              _lugar.text,
              _empleado.text,
              _patrono.text,
              _empresa.text,
              _rrhh.text,
              _cargo.text,
              _cargoRrhh.text,
              formant: PdfPageFormat.a4,
            );

            if (!mounted) return;

            context.push('/vista_previa', extra: pdfBytes);
          },
          text: 'Aceptar',
        ),

        AeroButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'Cancelar',
        ),
      ],
    );
  }
}
