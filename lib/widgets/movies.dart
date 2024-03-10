import 'package:flutter/material.dart';
import 'package:movie_app/Screens/details.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movielist.dart';

class Movies extends StatelessWidget {
  const Movies({
    Key? key,
    required this.movies,
    this.onRate,
  }) : super(key: key);

  final List<Movie> movies;
  final Function(int, double)? onRate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(movies.length, (index) {
            final movie = movies[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => DetailsScreen(
                        movieDetails: movie,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 170,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          '${Constants.imagePath}${movie.posterPath}',
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
