// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/cubit/favoritecubit.dart';
import 'package:movie_app/cubit/RatingCubit/rating_cubit.dart';
import 'package:movie_app/models/movielist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.movieDetails}) : super(key: key);
  final Movie movieDetails;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ratingController.text = widget.movieDetails.rating.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteMovieCubit, List<Movie>>(
      builder: (context, state) {
        final favoriteMoviesCubit = context.read<FavoriteMovieCubit>();
        final ratingCubit = context.read<RatingCubit>();
        final bool isFavorite = state.contains(widget.movieDetails);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 500,
                pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    widget.movieDetails.title,
                    style: GoogleFonts.belleza(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  background: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    child: Image.network(
                      '${Constants.imagePath}${widget.movieDetails.posterPath}',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () async {
                      double? rating;
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Rate this movie',
                                style: TextStyle(color: Colors.white)),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  const Text(
                                    'Select your rating (0-10):',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TextField(
                                    controller: _ratingController,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      rating = double.tryParse(value);
                                    },
                                    decoration: const InputDecoration(
                                        hintText: 'Enter rating',
                                        hintStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (rating != null &&
                                      rating! >= 0 &&
                                      rating! <= 10) {
                                    await ratingCubit.apiService
                                        .addRatingToMovie(
                                      widget.movieDetails.id,
                                      rating!,
                                    );
                                    setState(() {
                                      widget.movieDetails.rating = rating!;
                                    });
                                    Navigator.of(context).pop();
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          'Please enter a rating between 0 and 10.'),
                                    ));
                                  }
                                },
                                child: const Text('Rate'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  try {
                                    await ratingCubit.apiService
                                        .deleteRatingFromMovie(
                                      widget.movieDetails.id,
                                    );
                                    setState(() {
                                      widget.movieDetails.rating = 0;
                                    });
                                    Navigator.of(context).pop();
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Failed to delete rating'),
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Delete My rate'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final isToggled = favoriteMoviesCubit
                          .toggleMealFavoriteStatus(widget.movieDetails);
                      final bool isFavorite = isToggled;
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Your Rating: ${widget.movieDetails.rating} ',
                            style: GoogleFonts.openSans(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.movieDetails.overview,
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Release Date   ',
                                  style: GoogleFonts.roboto(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.movieDetails.releaseDate,
                                  style: GoogleFonts.roboto(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                Text(
                                  widget.movieDetails.voteAverage,
                                  style: GoogleFonts.roboto(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
