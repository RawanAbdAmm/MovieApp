import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/movielist.dart';

class FavoriteMovieCubit extends Cubit<List<Movie>> {
  FavoriteMovieCubit() : super([]);

  bool toggleMealFavoriteStatus(Movie movie) {
    final movieIsFavorite = state.contains(movie);
    if (movieIsFavorite) {
      emit(state.where((m) => m.id != movie.id).toList());
      return false;
    } else {
      emit([...state, movie]);
      return true;
    }
  }

  void removeFavoriteMovie(Movie movie) {
    emit(state.where((m) => m.id != movie.id).toList());
  }
}
