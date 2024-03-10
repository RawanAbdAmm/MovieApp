part of 'rating_cubit.dart';

abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingSuccess extends RatingState {}

class RatingFailure extends RatingState {
  final String error;

  RatingFailure(this.error);
}
