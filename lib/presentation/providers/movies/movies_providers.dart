import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifire, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(moviesRespositoryProvider).getNowPlaying;
  return MoviesNotifire(fetchMoreMovies: fetchMoreMovies);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifire, List<Movie>>((ref) {
  final fetchMorePopularMovies =
      ref.watch(moviesRespositoryProvider).getPopular;

  return MoviesNotifire(fetchMoreMovies: fetchMorePopularMovies);
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifire, List<Movie>>((ref) {
  final fetchMorePopularMovies =
      ref.watch(moviesRespositoryProvider).getTopRated;

  return MoviesNotifire(fetchMoreMovies: fetchMorePopularMovies);
});

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifire, List<Movie>>((ref) {
  final fetchMorePopularMovies =
      ref.watch(moviesRespositoryProvider).getUpComing;

  return MoviesNotifire(fetchMoreMovies: fetchMorePopularMovies);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifire extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifire({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(microseconds: 300));
    isLoading = false;
  }
}
