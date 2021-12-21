import 'dart:io';
import 'dart:typed_data';

import 'package:bmi_calculator/functional_classes/current_toast.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class StorageOfPhone {
  StorageOfPhone(this._nameOfFile);
  String _nameOfFile;
  Future<String> get _localPath async {
    final Directory directory = await getExternalStorageDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_nameOfFile');
  }

  void writeCounter(Uint8List bytes, BuildContext context) async {
    final file = await _localFile;

    file.writeAsBytes(bytes).then((value) {
      String filePath = value.parent.path;
      if (Platform.isAndroid) filePath = value.parent.path.substring(20);
      CurrentToast(context, 'BMI saved to $filePath').showCurrentCondition();
    });
  }

  Future<String> getPathOfSavingDirectory() async {
    Directory directory = await getExternalStorageDirectory();
    return directory.path;
  }
}
