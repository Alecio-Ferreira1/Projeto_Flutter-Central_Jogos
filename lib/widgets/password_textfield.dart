import 'package:central_jogos/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class PasswordTextfield extends StatelessWidget {
  final String? hint;
  final ValueChanged<String>? onchanged;

  const PasswordTextfield({required this.hint, this.onchanged, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      hint: hint,
      prefixIcon: const Icon(Icons.lock),
      isPassword: true,
      onchanged: onchanged,
    );
  }
}