import 'dart:io';
import 'package:file_picker/file_picker.dart';

Future<List<File>> picker() async {
  FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
      allowMultiple: true);

  //final path = (await getTemporaryDirectory()).path;

  if (result != null) {
    List<File> files = result.paths.map((path) => File(path)).toList();
    return files;
/*
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
      */

    /*
      final File newImage =
          await files.copy('$dir\\${year}data\\sheets\\$patientInfo$i.jpg');
*/

  } else {}
}
