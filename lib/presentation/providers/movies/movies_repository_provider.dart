import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/movies_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesRespositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(MoviedbDatasourceImpl());
});
