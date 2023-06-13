

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/hot_and_new/hot_and_new_service.dart';

import '../../domain/hot_and_new/model/hot_and_new.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';


@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;

  HomeBloc(this._homeService) : super(HomeState.initial()) {
    /* on Event get home screen data
    */

    on<GetHomeScreenData>((event, emit) async {
      // log('Getting Home Screen Data');
      // Send Loading to UI
      emit(state.copyWith(isLoading: true, hasError: false));
      // get Data
      final _movieResult = await _homeService.getHotAndNewMovieData();
      final _tvResult = await _homeService.getHotAndNewTvData();
      // transform Data

      final _state1 = _movieResult.fold((MainFailure failure) {
        return HomeState(
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
            stateId: DateTime.now().millisecondsSinceEpoch.toString());
      }, (HotAndNew response) {
        final pastYear = response.results;
        final trending = response.results;
        final dramas = response.results;
        final southIndian = response.results;

        pastYear.shuffle();
        trending.shuffle();
        dramas.shuffle();
        southIndian.shuffle();

        return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: pastYear,
            trendingMovieList: trending,
            tenseDramasMovieList: dramas,
            southIndianMovieList: southIndian,
            trendingTvList: state.trendingTvList,
            isLoading: false,
            hasError: false);
      });
      emit(_state1);

      final _state2 = _tvResult.fold(
        (MainFailure failure) {
          return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: [],
              trendingMovieList: [],
              tenseDramasMovieList: [],
              southIndianMovieList: [],
              trendingTvList: [],
              isLoading: false,
              hasError: true);
        },
        (HotAndNew response) {
          final top10List = response.results;
          return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: state.pastYearMovieList,
              trendingMovieList: top10List,
              tenseDramasMovieList: state.tenseDramasMovieList,
              southIndianMovieList: state.southIndianMovieList,
              trendingTvList: top10List,
              isLoading: false,
              hasError: false);
        },
      );

      // Send to UI

      emit(_state2);
    });
  }
}
