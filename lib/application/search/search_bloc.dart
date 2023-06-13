import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/downloads/i_downloads_repo.dart';
import 'package:netflix_app/domain/search/search_service.dart';

import '../../domain/downloads/models/downloads.dart';
import '../../domain/search/model/search_response/search_response/search_response.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepo _downloadsService;
  final SearchService _searchService;
  SearchBloc(
    this._downloadsService,
    this._searchService,
  ) : super(SearchState.initial()) {
    /*
  idle State
  */
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(state);
        return;
      }
      emit(const SearchState(
        searchResultList: [],
        idleList: [],
        isLoading: true,
        isError: false,
      ));
      // get trending
      final _result = await _downloadsService.getDownloadsImages();
      _result.fold((MainFailure f) {
        emit(const SearchState(
          searchResultList: [],
          idleList: [],
          isLoading: false,
          isError: true,
        ));
      }, (List<Downloads> list) {
        emit(SearchState(
          searchResultList: [],
          idleList: list,
          isLoading: false,
          isError: false,
        ));
      });
      // show to ui
    });
    /*
    search result state
     */
    on<SearchMovie>((event, emit) async {
      // call search movie api
      log('Searching for ${event.movieQuery}');
      emit(const SearchState(
        searchResultList: [],
        idleList: [],
        isLoading: true,
        isError: false,
      ));
      final _result =
          await _searchService.searchMovies(movieQuery: event.movieQuery);
      _result.fold(
        (MainFailure f) {
          emit(const SearchState(
            searchResultList: [],
            idleList: [],
            isLoading: true,
            isError: false,
          ));
        },
        (SearchResponse r) {
          emit(SearchState(
            searchResultList: r.results ?? [],
            idleList: [],
            isLoading: false,
            isError: false,
          ));
        },
      );
      // show to ui
    });
  }
}
