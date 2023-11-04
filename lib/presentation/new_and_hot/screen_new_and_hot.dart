import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix_app/core/colors.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/everyones_watching_widget.dart';
import 'dart:core';
import '../../application/hot_and_new/hot_and_new_bloc.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            title: const Text(
              "New & Hot",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            actions: const [
              Icon(
                Icons.cast,
                color: Colors.white,
                size: 30,
              ),
              kWidth,
              Icon(
                Icons.tv,
                color: Colors.white,
                size: 30,
              ),
              kWidth,
            ],
            bottom: TabBar(
                unselectedLabelColor: kWhiteColor,
                labelColor: kBlackColor,
                isScrollable: true,
                labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: kRadius30,
                ),
                tabs: const [
                  Tab(
                    text: "🍿 Coming Soon",
                  ),
                  Tab(
                    text: "👀 Everyone's watching",
                  ),
                ]),
          ),
        ),
        body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              ComingSoonList(
                key: Key('Coming Soon'),
              ),
              EveryoneIsWatchingList(
                key: Key('Everyone is Watching'),
              ),
            ]),
      ),
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    });

    return RefreshIndicator(
      color: Colors.black54,
      strokeWidth: 3,
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text("Error while loading coming soon list",
                  style: TextStyle(color: Colors.white)),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text("Coming Soon List is Empty",
                  style: TextStyle(color: Colors.white)),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: state.comingSoonList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.comingSoonList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }
                  final date = DateTime.parse(movie.releaseDate!);
                  final formatedDate = DateFormat.yMMMMd('en_US').format(date);
                  final parts = formatedDate.split(' ');
                  final monthAbbreviation =
                      parts[0].substring(0, 3).toUpperCase();
                  final isLastItem = index == state.comingSoonList.length - 1;
                  return ComingSoonWidget(
                    id: movie.id.toString(),
                    month: monthAbbreviation,
                    day: movie.releaseDate!.split('-')[1],
                    posterPath: '$imageAppendUrl${movie.posterPath}',
                    movieName: movie.originalTitle ?? 'No Title',
                    description: movie.overview ?? 'No Description',
                    isLastItem: isLastItem,
                  );
                });
          }
        },
      ),
    );
  }
}

class EveryoneIsWatchingList extends StatelessWidget {
  const EveryoneIsWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryoneIsWatching());
    });

    return RefreshIndicator(
      color: Colors.black54,
      strokeWidth: 3,
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryoneIsWatching());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
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
                "Error while loading coming soon list",
                style: TextStyle(color: Colors.white),
              ),
            );
          } else if (state.everyOneIsWatchingList.isEmpty) {
            return const Center(
              child: Text("Everyone is Watching List is Empty",
                  style: TextStyle(color: Colors.white)),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: state.everyOneIsWatchingList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.everyOneIsWatchingList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }

                  final tv = state.everyOneIsWatchingList[index];
                  final isLastItem = index == state.comingSoonList.length - 1;

                  return EveryonesWatchingWidget(
                    posterPath: '$imageAppendUrl${tv.posterPath}',
                    movieName: tv.originalName ?? 'No Name provided',
                    description: tv.overview ?? 'No Description',
                    isLastItem: isLastItem,
                  );
                });
          }
        },
      ),
    );
  }
}
