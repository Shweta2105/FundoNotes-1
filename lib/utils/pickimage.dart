import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

PickImage(ImageSource _source) async {
  final ImagePicker _imagepicker = ImagePicker();
  XFile? _file = await _imagepicker.pickImage(source: ImageSource.gallery);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected');
}
