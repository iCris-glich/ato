import 'package:creador_pdf/formato/constancia_laboral/formato_carta_constancia_laboral.dart';
import 'package:creador_pdf/servicio/servicio_historial.dart';
import 'package:creador_pdf/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';

class FormularioConstanciaLaboral extends StatefulWidget {
  const FormularioConstanciaLaboral({super.key});

  @override
  State<FormularioConstanciaLaboral> createState() =>
      _FormularioConstanciaLaboralState();
}

class _FormularioConstanciaLaboralState
    extends State<FormularioConstanciaLaboral> {
  final _empleado = TextEditingController();
  final _dpi = TextEditingController();
  final _cargo = TextEditingController();
  final _empresa = TextEditingController();
  final _lugar = TextEditingController();
  final _salario = TextEditingController();
  final _redactor = TextEditingController();
  final _cargoRedactor = TextEditingController();
  final _telefono = TextEditingController();
  final _correo = TextEditingController();

  @override
  void dispose() {
    _empleado.dispose();
    _dpi.dispose();
    _cargo.dispose();
    _empresa.dispose();
    _lugar.dispose();
    _salario.dispose();
    _redactor.dispose();
    _cargoRedactor.dispose();
    _telefono.dispose();
    _correo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Llena los datos para generar tu constancia laboral'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextfield(
              controller: _empleado,
              texto: 'Nombre del empleado',
              icono: const Icon(Icons.person),
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              controller: _dpi,
              texto: 'DPI',
              icono: const Icon(Icons.badge_outlined),
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              controller: _cargo,
              texto: 'Cargo del empleado',
              icono: const Icon(Icons.work),
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              controller: _empresa,
              texto: 'Nombre de la empresa',
              icono: const Icon(Icons.business),
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              controller: _lugar,
              texto: 'Lugar de trabajo',
              icono: const Icon(Icons.location_on),
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              controller: _salario,
              texto: 'Salario',
              icono: const Icon(Icons.attach_money),
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              controller: _correo,
              texto: 'Correo electrónico',
              icono: const Icon(Icons.email),
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              controller: _telefono,
              texto: 'Número de contacto',
              icono: const Icon(Icons.phone),
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              controller: _redactor,
              texto: 'Encargado de RRHH',
              icono: const Icon(Icons.groups),
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              controller: _cargoRedactor,
              texto: 'Cargo del encargado de RRHH',
              icono: const Icon(Icons.work_outline),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            final ahora = DateTime.now();
            final fecha =
                '${ahora.day.toString().padLeft(2, '0')}/'
                '${ahora.month.toString().padLeft(2, '0')}/'
                '${ahora.year}';

            final hora =
                '${ahora.hour.toString().padLeft(2, '0')}:${ahora.minute.toString().padLeft(2, '0')}';

            ServicioHistorial.instance.agregarRegistro(
              documento: 'Constancia laboral',
              fecha: fecha,
              hora: hora,
              beneficiado: _empleado.text,
            );

            final pdfBytes = await crearCartaLaboral(
              _lugar.text,
              _empleado.text,
              _dpi.text,
              _empresa.text,
              _cargo.text,
              _salario.text,
              _redactor.text,
              _cargoRedactor.text,
              _telefono.text,
              _correo.text,
              fecha,
              formant: PdfPageFormat.a4,
            );

            if (!mounted) return;

            context.pop(); // cierra el diálogo

            context.push('/vista_previa', extra: pdfBytes);
          },
          child: const Text('Aceptar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
