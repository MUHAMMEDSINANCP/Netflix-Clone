import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/downloads/downloads_service.dart';
import '../../domain/downloads/models/downloads.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final dummyVideoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
];

ValueNotifier<Set<int>> likedVideosIdsNotifier = ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(
    DownloadsService downloadService,
  ) : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      if (state.videoslist.isNotEmpty) {
        emit(state);
        return;
      }

      // Sending Loading to UI
      emit(const FastLaughState(
        videoslist: [],
        isLoading: true,
        isError: false,
      ));
      // get trending movies
      final result = await downloadService.getDownloadsImages();
      final states = result.fold((l) {
        return const FastLaughState(
          videoslist: [],
          isLoading: false,
          isError: true,
        );
      },
          (response) => FastLaughState(
                videoslist: response,
                isLoading: false,
                isError: false,
              ));
      // send to ui
      emit(states);
    });

    on<LikeVideo>((event, emit) async {
      likedVideosIdsNotifier.value.add(event.id);
      // likedVideosIdsNotifier.notifyListeners();
    });

    on<UnlikeVideo>((event, emit) async {
      likedVideosIdsNotifier.value.remove(event.id);
      // likedVideosIdsNotifier.notifyListeners();
    });
  }
}
