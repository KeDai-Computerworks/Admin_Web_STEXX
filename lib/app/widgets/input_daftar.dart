import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputDaftar extends StatelessWidget {
  // final String label;
  final TextEditingController controller;
  final InputDecoration? decoration;
  final int minLines;
  final String? Function(String?)? validator;
  final bool isNumeric;
  const InputDaftar({
    super.key,
    // required this.label,
    required this.controller,
    this.decoration,
    this.minLines = 1,
    this.validator,
    this.isNumeric = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: TextFormField(
          maxLines: minLines,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          inputFormatters:
              isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
          controller: controller,
          decoration: decoration,
          validator: validator,
        ),
      ),
    );
  }
}
