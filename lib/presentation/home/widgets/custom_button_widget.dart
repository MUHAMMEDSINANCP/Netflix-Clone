import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.iconSize = 30,
    this.textSize = 18,
    this.textColor = Colors.white,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final double iconSize;
  final double textSize;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: kWhiteColor,
          size: iconSize,
        ),
        Text(
          title,
          style: TextStyle(fontSize: textSize, color: textColor),
        ),
      ],
    );
  }
}
