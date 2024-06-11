import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final GestureDetector? icon;
  final bool obscureText;
  const TextFieldCustom({
    super.key,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.validator,
    required this.controller,
    this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: icon,
          ),
        ),
      ],
    );
  }
}
