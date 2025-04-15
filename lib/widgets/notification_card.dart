import 'package:central_jogos/colors/colors.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final Icon icon;
  final String desc, timeDesc;

  const NotificationCard({
    required this.icon, required this.desc,
    required this.timeDesc, super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon, 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              desc, 
              style: const TextStyle(fontSize: 14, color: AppColors.black),
            ),
            Text(
              timeDesc, 
              style: const TextStyle(fontSize: 12, color: Color(0xFF3C3E56)),
            ),
          ],
        ),
      ],
    );
  }
}