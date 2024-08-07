import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomField extends StatefulWidget {
  final IconData icon;
  final String lable;
  final TextEditingController controller;
  final bool isPass;
  const CustomField({
    super.key,
    required this.icon,
    required this.lable,
    required this.controller,
    this.isPass = false,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        validator: (value) => value!.isEmpty ? "Requird" : null,
        controller: widget.controller,
        decoration: InputDecoration(         
          contentPadding: const EdgeInsets.all(12),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color.fromARGB(0, 221, 62, 62))),
          labelText: widget.lable,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
