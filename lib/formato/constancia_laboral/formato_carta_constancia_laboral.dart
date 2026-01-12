import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> crearCartaLaboral(
  String lugar,
  String empleado,
  String dpi,
  String empresa,
  String cargo,
  String salario,
  String redactor,
  String cargoRedactor,
  String telefono,
  String correo,
  String fecha, {
  PdfPageFormat formant = PdfPageFormat.a4,
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: formant,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Align(alignment: pw.Alignment.topLeft, child: pw.Text(empresa)),
            pw.Align(alignment: pw.Alignment.topLeft, child: pw.Text(lugar)),
            pw.Align(
              alignment: pw.Alignment.topLeft,
              child: pw.Text(telefono.toString()),
            ),

            pw.SizedBox(height: 30),
            pw.Align(alignment: pw.Alignment.topLeft, child: pw.Text(fecha)),

            pw.SizedBox(height: 120),

            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(
                'A quien corresponda',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.SizedBox(height: 10),

            pw.Text(
              'Por medio de la presenete, certificamos que el Sr/Sra. $empleado quien se identifica con la identificacion $dpi labora en nuestra empresa $empresa desde 10 de enero de 2025, desempeñando como $cargo. \n Actualmente, percibe un salario mensual de Q${salario.toString()}.',
            ),

            pw.SizedBox(height: 10),

            pw.Text(
              'Para cualquier consulta adicional pueden comunicarse con nosotros por medio de nuestro número de teléfono $telefono, o al correo $correo',
            ),

            pw.SizedBox(height: 20),

            pw.Align(
              alignment: pw.Alignment.bottomLeft,
              child: pw.Text(
                'Atentamente\n $redactor\n $cargoRedactor\n $empresa',
              ),
            ),
            pw.Align(
              alignment: pw.Alignment.bottomRight,
              child: pw.Text(
                '_______________________\n \n    Yo $redactor\n    $cargoRedactor',
                style: pw.TextStyle(fontSize: 13),
              ),
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
