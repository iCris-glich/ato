import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> crearCartaRenuncia(
  String lugar,
  String empleado,
  String patrono,
  String empresa,
  String rrhh,
  String cargo,
  String cargoRrhh, {
  PdfPageFormat formant = PdfPageFormat.a4,
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: formant,
      build: (pw.Context context) {
        return pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Align(
              alignment: pw.Alignment.topRight,
              child: pw.Text('07 de Enero de 2026'),
            ),
            pw.Align(alignment: pw.Alignment.topRight, child: pw.Text(lugar)),
            pw.Align(alignment: pw.Alignment.topRight, child: pw.Text(empresa)),
            pw.Align(
              alignment: pw.Alignment.bottomLeft,
              child: pw.Text('$rrhh, $cargoRrhh'),
            ),
            pw.SizedBox(height: 20),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(
                'Un gusto el poder saludarles, por medio de la presente carta quisiera \n Hacer saber sobre mi renuncia $empleado, de la posicion $cargo',
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              children: [
                pw.Text('F ._________________\n \n $empleado, $cargo'),
              ],
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
