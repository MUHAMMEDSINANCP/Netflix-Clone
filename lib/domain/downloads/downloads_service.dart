import 'package:dartz/dartz.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/downloads/models/downloads.dart';

abstract class DownloadsService {
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImages();
}
