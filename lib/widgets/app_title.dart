import 'package:central_jogos/colors/colors.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: "Central Jogos\n",
            style: TextStyle(
              color: AppColors.blue,
              fontSize: 45,
              decoration: TextDecoration.none,
            ),
          ),
          TextSpan(
            text: "        IFMA",
            style: TextStyle(
              color: Color(0xFF00F8FF),
              fontSize: 45,
              decoration: TextDecoration.none,
            ),
          ),
        ]
      ),
    );
  }
}