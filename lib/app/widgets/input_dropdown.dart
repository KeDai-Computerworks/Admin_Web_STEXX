import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputDaftarWithDropdownButton extends StatelessWidget {
  final InputDecoration? decoration;
  const InputDaftarWithDropdownButton({
    super.key,
    required this.dropdownValue,
    this.decoration,
    required this.items,
    this.validator,
  });

  final RxString dropdownValue;
  final List<String> items;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Obx(
          () => DropdownButtonFormField<String>(
            value: dropdownValue.value,
            isExpanded: true,
            elevation: 8,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                enabled: true,
                value: value,
                child: Text(
                  value,
                  // maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              dropdownValue.value = newValue!;
            },
            decoration: decoration,
            validator: validator,
          ),
        ),
      ),
    );
  }
}
