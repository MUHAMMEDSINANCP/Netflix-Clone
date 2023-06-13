import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        color: kWhiteColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
