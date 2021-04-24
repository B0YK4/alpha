import 'dart:io';
import 'package:filepicker_windows/filepicker_windows.dart';

// Normal file open dialog box example
String picker() {
  final file = OpenFilePicker();
  file.filterSpecification = {
    'Image Sheet (*.jpg,*.png,*.jpg)': '*.jpg;*.png;*.jpeg',
  };
  file.hidePinnedPlaces = true;
  file.forcePreviewPaneOn = true;
  file.title = 'Select a sheet';

  final result = file.getFile();
  if (result != null) {
    print(result.path);
    return result.path;
  }
  return null;
}
/*

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
*/
