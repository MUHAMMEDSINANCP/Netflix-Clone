import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_app/core/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: GoogleFonts.montserrat().copyWith(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.cast,
          color: Colors.white,
          size: 27,
        ),
        kWidth,
        const Icon(
          Icons.person,
          color: Colors.white,
          size: 30,
        ),
        kWidth,
      ],
    );
  }
}
