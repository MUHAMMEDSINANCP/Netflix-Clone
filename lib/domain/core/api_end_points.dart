import 'package:netflix_app/infrastructure/api_key.dart';

class ApiEndPoints {
  static const kBaseUrl = "https://api.themoviedb.org/3";

  static const downloads = "$kBaseUrl/trending/movie/day?api_key=$apiKey";
  static const search = "$kBaseUrl/search/movie?api_key=$apiKey";

  static const hotAndNewMovie = '$kBaseUrl/discover/movie?api_key=$apiKey';
  static const hotAndNewTv = '$kBaseUrl/discover/tv?api_key=$apiKey';
}
