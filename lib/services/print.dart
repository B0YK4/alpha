import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> printImage(File immg) async {
  final doc = pw.Document();

  final image = await networkImage(
      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg');

  doc.addPage(pw.Page(build: (pw.Context context) {
    return pw.Center(
      child: pw.Image(image),
    ); // Center
  }));

  return doc.save();
}
