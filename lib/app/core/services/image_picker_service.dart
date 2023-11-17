import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sentinela/app/core/exceptions/image_picker_service_exception.dart';

class ImagePickerService {
  late File _imageFile = File("");
  final _picker = ImagePicker();

  Future<void> getImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    } on PlatformException catch (e, s) {
      log("Erro em pegar as imagens", error: e, stackTrace: s);
      throw ImagePickerServiceException("Erro em pegar as imagens");
    }
  }

  File get image => _imageFile;
}
