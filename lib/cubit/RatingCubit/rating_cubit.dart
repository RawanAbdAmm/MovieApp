import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/helper/api.dart';
part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingInitial());

  final Api apiService = Api();

  void rateMovie(int movieId, double rating) async {
    try {
      emit(RatingLoading());

      await apiService.addRatingToMovie(movieId, rating);

      emit(RatingSuccess());
    } catch (e) {
      emit(RatingFailure("Failed to rate the movie: $e"));
    }
  }

  void deleteRating(int movieId) async {
    try {
      emit(RatingLoading());

      await apiService.deleteRatingFromMovie(movieId);

      emit(RatingSuccess());
    } catch (e) {
      emit(RatingFailure("Failed to delete the rating: $e"));
    }
  }
}
