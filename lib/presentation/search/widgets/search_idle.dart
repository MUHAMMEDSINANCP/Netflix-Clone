import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/search/search_bloc.dart';
import 'package:netflix_app/core/colors.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/search/widgets/title.dart';

class SearchIdleWidget extends StatelessWidget {
  const SearchIdleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'Top Searches'),
        kHeight,
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.isError) {
                    return const Center(
                      child: Text(
                        'Error while getting data',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (state.idleList.isEmpty) {
                    return const Center(
                      child: Text('List is Empty',
                          style: TextStyle(color: Colors.white)),
                    );
                  }
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        final movie = state.idleList[index];
                        return TopSearchItemTile(
                            title: movie.title ?? 'No Title Provided',
                            imageUrl: '$imageAppendUrl${movie.posterPath}');
                      },
                      separatorBuilder: (ctx, index) => kHeight20,
                      itemCount: state.idleList.length);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItemTile(
      {super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          width: screenWidth * 0.38,
          height: 80,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                imageUrl,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
          title,
          style: const TextStyle(
            color: kWhiteColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )),
        const CircleAvatar(
          backgroundColor: kWhiteColor,
          radius: 22,
          child: CircleAvatar(
            backgroundColor: kBlackColor,
            radius: 20,
            child: Padding(
              padding: EdgeInsets.only(left: 4),
              child: Icon(
                CupertinoIcons.play_fill,
                color: kWhiteColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
