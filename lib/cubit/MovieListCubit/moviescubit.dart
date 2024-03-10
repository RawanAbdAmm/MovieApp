import 'package:bloc/bloc.dart';
import 'package:movie_app/helper/api.dart';
import 'package:movie_app/models/movielist.dart';

part 'movie_cubit_state.dart';

class MovieCubit extends Cubit<MovieCubitState> {
  MovieCubit() : super(const MovieCubitInitial());

  void getMovies() async {
    emit(const MovieCubitLoading());
    try {
      final List<Movie> trendingMovies = await Api().getTrendingMovies();
      final List<Movie> topRatedMovies = await Api().getTopRatedMovies();
      final List<Movie> upcomingMovies = await Api().getUpcomingMovies();

      emit(MovieCubiSuccess(
        trendingMovie: trendingMovies,
        upcomingMovie: upcomingMovies,
        topRatedMovie: topRatedMovies,
      ));
    } catch (e) {
      emit(MovieCubiFailure(errMessage: e.toString()));
    }
  }

  void searchForMovie({required String searchValue}) async {
    if (searchValue.isEmpty) {
      emit(const MovieCubiFailure(errMessage: 'Search value is empty'));
      return;
    }
    emit(const MovieCubitLoading());
    try {
      final searchMovies = await Api().getSearchedMovie(searchValue);
      emit(MovieCubiSuccess(searchMovie: searchMovies));
    } catch (e) {
      emit(MovieCubiFailure(errMessage: e.toString()));
    }
  }

  void getTvShows() async {
    emit(const MovieCubitLoading());
    try {
      final tvShows = await Api().gettvShows();
      emit(MovieCubiSuccess(trendingMovie: tvShows));
    } catch (e) {
      emit(MovieCubiFailure(errMessage: e.toString()));
    }
  }

  void getNowPlayingShows() async {
    emit(const MovieCubitLoading());
    try {
      final nowPlayingShows = await Api().getNowPlayingShows();
      emit(MovieCubiSuccess(upcomingMovie: nowPlayingShows));
    } catch (e) {
      emit(MovieCubiFailure(errMessage: e.toString()));
    }
  }

  void getPopularMovies() async {
    emit(const MovieCubitLoading());
    try {
      final popularMovie = await Api().getPopularMovies();
      emit(MovieCubiSuccess(
          topRatedMovie: [popularMovie])); // Wrap the single movie in a list
    } catch (e) {
      emit(MovieCubiFailure(errMessage: e.toString()));
    }
  }

  void addRatingToMovie({required int movieId, required double rating}) async {
    try {
      await Api().addRatingToMovie(movieId, rating);
    } catch (e) {}
  }
}
