import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors.dart';

class VideoWidget extends StatelessWidget {
  final String url;
  final double height;

  const VideoWidget({
    Key? key,
    required this.url,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height,
          child: Image.network(url, fit: BoxFit.cover, loadingBuilder:
              (BuildContext _, Widget child, ImageChunkEvent? progress) {
            if (progress == null) {
              return child;
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            }
          }, errorBuilder: (BuildContext _, Object a, StackTrace? trace) {
            return const Center(
                child: Icon(
              Icons.wifi,
              color: kWhiteColor,
            ));
          }),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            radius: 25,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.volume_off,
                color: kWhiteColor,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
