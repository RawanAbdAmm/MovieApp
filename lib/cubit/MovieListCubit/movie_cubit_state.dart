part of 'moviescubit.dart';

abstract class MovieCubitState {
  const MovieCubitState();
}

class MovieCubitInitial extends MovieCubitState {
  const MovieCubitInitial();
}

class MovieCubitLoading extends MovieCubitState {
  const MovieCubitLoading();
}

class MovieCubiSuccess extends MovieCubitState {
  final List<Movie>? trendingMovie;
  final List<Movie>? upcomingMovie;
  final List<Movie>? topRatedMovie;
  final List<Movie>? searchMovie;
  final List<Movie>? favoritMovie;

  const MovieCubiSuccess({
    this.trendingMovie,
    this.upcomingMovie,
    this.topRatedMovie,
    this.searchMovie,
    this.favoritMovie,
  });
}

class MovieCubiFailure extends MovieCubitState {
  final String errMessage;

  const MovieCubiFailure({required this.errMessage});
}
