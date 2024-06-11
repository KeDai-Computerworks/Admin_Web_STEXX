import 'package:flutter/material.dart';

class InputDaftarAndButton extends StatelessWidget {
  // final String label;
  final TextEditingController controller;
  final InputDecoration? decoration;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  const InputDaftarAndButton({
    super.key,
    // required this.label,
    required this.controller,
    this.decoration,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          validator: validator,
          decoration: decoration!
              .copyWith(suffixIcon: const Icon(Icons.arrow_drop_down)),
        ),
      ),
    );
  }
}
