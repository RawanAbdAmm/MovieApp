// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/cubit/favoritecubit.dart';
import 'package:movie_app/models/movielist.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteMoviesCubit = BlocProvider.of<FavoriteMovieCubit>(context);

    return BlocBuilder<FavoriteMovieCubit, List<Movie>>(
      builder: (context, favoriteMovies) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 50,
                ),
                const SizedBox(width: 60),
                const Text(
                  'Favorite Movies',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: favoriteMovies.isEmpty
                    ? const Center(
                        child: Text(
                          'No favorite movies yet',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: favoriteMovies.length,
                        itemBuilder: (context, index) {
                          final movie = favoriteMovies[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 4,
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8),
                                leading: Image.network(
                                  '${Constants.imagePath}${movie.posterPath}',
                                  width: 80,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Release Date: ${movie.releaseDate}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    favoriteMoviesCubit
                                        .removeFavoriteMovie(movie);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
