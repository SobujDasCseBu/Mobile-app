import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    inspect('Open images');
    var files = await FilePicker.platform.pickFiles(
      //type: FileType.image,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
