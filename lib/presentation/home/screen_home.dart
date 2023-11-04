import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/home/home_bloc.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/home/widgets/background_card.dart';
import 'package:netflix_app/presentation/home/widgets/number_title_card.dart';
import 'package:netflix_app/presentation/widgets/main_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: scrollNotifier,
        builder: (BuildContext context, index, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.reverse) {
                scrollNotifier.value = false;
              } else if (direction == ScrollDirection.forward) {
                scrollNotifier.value = true;
              }
              return true;
            },
            child: Stack(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    } else if (state.hasError) {
                      return const Center(
                          child: Text(
                        'Error While getting Data',
                        style: TextStyle(color: Colors.white),
                      ));
                    }

                    /// released Past Year
                    final releasedPastYear = state.pastYearMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();

                    /// Trending
                    final trending = state.trendingMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();

                    ///    Tense Daramas
                    final tenseDramas = state.tenseDramasMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();

                    /// South Indian Cinema
                    final southIndianMovies =
                        state.southIndianMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();

                    southIndianMovies.shuffle();

                    // top 10 tv shows
                    final top10TvShow = state.trendingTvList.map((t) {
                      return '$imageAppendUrl${t.posterPath}';
                    }).toList();
                    top10TvShow.shuffle();

                    // Listview

                    return ListView(
                      children: [
                        const BackGroundCard(),
                        if (releasedPastYear.length >= 10)
                          MainTitleCard(
                            posterList: releasedPastYear.sublist(0, 10),
                            title: "Released in the past year",
                          ),
                        kHeight,
                        if (trending.length >= 10)
                          MainTitleCard(
                            title: "Trending Now",
                            posterList: trending.sublist(0, 10),
                          ),
                        kHeight,
                        if (top10TvShow.length >= 10)
                          NumberTitleCard(
                            postersList: top10TvShow.sublist(0, 10),
                          ),
                        kHeight,
                        if (tenseDramas.length >= 10)
                          MainTitleCard(
                            title: "Tense Dramas",
                            posterList: tenseDramas.sublist(0, 10),
                          ),
                        kHeight,
                        if (southIndianMovies.length >= 10)
                          MainTitleCard(
                            title: "South Indian Cinema",
                            posterList: southIndianMovies.sublist(0, 10),
                          ),
                        kHeight,
                      ],
                    );
                  },
                ),
                scrollNotifier.value == true
                    ? AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: double.infinity,
                        height: 90,
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Image.network(
                                    "https://www.edigitalagency.com.au/wp-content/uploads/netflix-logo-png-large.png",
                                    width: 80,
                                    height: 60,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.cast,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                kWidth,
                                const Icon(
                                  Icons.movie,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                kWidth,
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "TV Shows",
                                  style: kHomeTitleText,
                                ),
                                Text(
                                  "Movies",
                                  style: kHomeTitleText,
                                ),
                                Text(
                                  "Categories",
                                  style: kHomeTitleText,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : kHeight,
              ],
            ),
          );
        },
      ),
    );
  }
}
