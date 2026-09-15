import 'package:flutter/material.dart';

class BilingualInputField extends StatelessWidget {
  final String englishLabel;
  final String hindiLabel;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const BilingualInputField({
    super.key,
    required this.englishLabel,
    required this.hindiLabel,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              englishLabel,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(width: 4),
            Text(
              '/',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
            const SizedBox(width: 4),
            Text(
              hindiLabel,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}
