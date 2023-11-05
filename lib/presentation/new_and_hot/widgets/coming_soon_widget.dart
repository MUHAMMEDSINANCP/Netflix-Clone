import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix_app/presentation/widgets/video_widget.dart';

class ComingSoonWidget extends StatefulWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;
  final bool isLastItem;

  const ComingSoonWidget({
    Key? key,
    required this.id,
    required this.month,
    required this.day,
    required this.posterPath,
    required this.movieName,
    required this.description,
    required this.isLastItem,
  }) : super(key: key);

  @override
  ComingSoonWidgetState createState() => ComingSoonWidgetState();
}

class ComingSoonWidgetState extends State<ComingSoonWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        SizedBox(
          height: 680,
          width: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.month,
                style: const TextStyle(
                  fontSize: 16,
                  color: kGreyColor,
                ),
              ),
              Text(
                widget.day,
                style: const TextStyle(
                  fontSize: 30,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  color: kWhiteColor,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: size.width - 60,
          height: 700,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: VideoWidget(
                  url: widget.posterPath,
                  height: 400, // Specify the height for VideoWidget
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.movieName,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        color: kWhiteColor.withOpacity(0.5),
                        letterSpacing: -2,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      CustomButtonWidget(
                        icon: CupertinoIcons.bell,
                        iconSize: 20,
                        textSize: 12,
                        title: "Remind me",
                      ),
                      kWidth,
                      CustomButtonWidget(
                        icon: Icons.info,
                        iconSize: 20,
                        textSize: 12,
                        title: "Info",
                      ),
                      kWidth,
                    ],
                  ),
                ],
              ),
              kHeight,
              Text(
                " Coming on ${widget.day} ${widget.month}",
                style: const TextStyle(color: Colors.grey),
              ),
              kHeight,
              // Add Read More/Read Less functionality to the description
              Text(
                isExpanded
                    ? widget.description
                    : widget.description.substring(
                        0, 100), // Display only a part of the description
                style: const TextStyle(fontSize: 16, color: kGreyColor),
              ),
              if (widget.description.length > 100) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    isExpanded ? "Read Less" : "Read More",
                    style: TextStyle(
                        color: Colors.redAccent
                            .shade200), // Customize the text style as needed
                  ),
                ),
              ],
              kHeight20,
              if (!widget.isLastItem)
                const Divider(
                  height: 7,
                  color: Colors.grey,
                ),
              kHeight20
            ],
          ),
        ),
      ],
    );
  }
}
