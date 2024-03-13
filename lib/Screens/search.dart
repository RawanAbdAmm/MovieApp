import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubit/MovieListCubit/moviescubit.dart';
import 'package:movie_app/models/movielist.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/Screens/details.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              CupertinoSearchTextField(
                controller: searchController,
                padding: const EdgeInsets.all(10.0),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  context.read<MovieCubit>().searchForMovie(searchValue: value);
                },
              ),
              BlocBuilder<MovieCubit, MovieCubitState>(
                builder: (context, state) {
                  if (state is MovieCubitLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieCubiSuccess) {
                    final List<Movie>? searchResults = state.searchMovie;
                    if (searchResults == null || searchResults.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'No movies found',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      );
                    }
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: searchResults.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 9,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1.9 / 2,
                      ),
                      itemBuilder: (context, index) {
                        final movie = searchResults[index];
                        if (movie == null) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      movieDetails: movie,
                                    ),
                                  ),
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${Constants.imagePath}${movie.backDropPath}',
                                height: 170,
                              ),
                            ),
                            Text(
                              movie.title,
                              maxLines: 2,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (state is MovieCubiFailure) {
                    return Center(child: Text(state.errMessage));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
