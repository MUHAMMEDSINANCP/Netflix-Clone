import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix_app/presentation/fast_laugh/widgets/video_list_items.dart';

class ScreenFastLaugh extends StatelessWidget {
  const ScreenFastLaugh({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FastLaughBloc>(context).add(const Initialize());
    });
    return Scaffold(
        body: SafeArea(child: BlocBuilder<FastLaughBloc, FastLaughState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        } else if (state.isError) {
          return const Center(
              child: Text(
            'Error while getting data',
            style: TextStyle(
              color: Colors.white,
            ),
          ));
        } else if (state.videoslist.isEmpty) {
          return const Center(
              child: Text(
            'video list is Empty',
            style: TextStyle(
              color: Colors.white,
            ),
          ));
        } else {
          return PageView(
            scrollDirection: Axis.vertical,
            children: List.generate(state.videoslist.length, (index) {
              return VideoListItemInheritedWidget(
                widget: VideoListItem(
                  key: Key(index.toString()),
                  index: index,
                ),
                movieData: state.videoslist[index],
              );
            }),
          );
        }
      },
    )));
  }
}
