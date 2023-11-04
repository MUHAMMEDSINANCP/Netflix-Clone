import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors.dart';
import 'package:netflix_app/core/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index, required this.imageUrl});
  final int index;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 200,
            ),
            Container(
              width: 130,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: kRadius10,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
              ),
            ),
          ],
        ),
        Positioned(
            left: 10,
            bottom: -30,
            child: BorderedText(
              strokeWidth: 10.0,
              strokeColor: kWhiteColor,
              child: Text(
                "${index + 1}",
                style: const TextStyle(
                    fontSize: 140,
                    fontWeight: FontWeight.bold,
                    color: kBlackColor,
                    decoration: TextDecoration.none,
                    decorationColor: Colors.red),
              ),
            ))
      ],
    );
  }
}
