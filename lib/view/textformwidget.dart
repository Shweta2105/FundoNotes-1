import 'package:flutter/material.dart';
import 'package:fundonotes/models/common/constants.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    Key? key,
    required this.controller,
    required this.hint
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: new TextStyle(
          fontStyle: FontStyle.normal, fontSize: 15, color: textcolor),
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
      ),
    );
  }
}
