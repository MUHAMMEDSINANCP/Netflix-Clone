import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netflix_app/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix_app/presentation/widgets/video_widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/colors.dart';
import '../../../core/constants.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;
  final bool isLastItem;

  const EveryonesWatchingWidget({
    super.key,
    required this.posterPath,
    required this.movieName,
    required this.description,
    required this.isLastItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight,
        Text(
          movieName,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        kHeight,
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, color: kGreyColor),
        ),
        kHeight50,
        VideoWidget(
          url: posterPath,
          height: 500,
        ),
        kHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const CustomButtonWidget(
              icon: Icons.play_arrow,
              title: "Play",
              iconSize: 35,
              textSize: 15,
            ),
            kWidth,
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: CustomButtonWidget(
                icon: Icons.add,
                title: "My List",
                iconSize: 31,
                textSize: 15,
              ),
            ),
            kWidth,
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: GestureDetector(
                onTap: () {
                  log('Share Clicked');

                  Share.share(movieName);
                },
                child: const CustomButtonWidget(
                  icon: Icons.share,
                  title: "Share",
                  iconSize: 27,
                  textSize: 15,
                ),
              ),
            ),
            kWidth,
          ],
        ),
        kHeight,
        if (!isLastItem)
          const Divider(
            height: 7,
            color: Colors.grey,
          ),
        kHeight20,
      ],
    );
  }
}
