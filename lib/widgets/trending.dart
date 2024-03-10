import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Screens/details.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movielist.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final List<Movie>? snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot == null || snapshot!.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      width: double.infinity,
      child: OrientationBuilder(
        builder: (context, orientation) {
          final isLandscape = orientation == Orientation.landscape;
          final double screenHeight = MediaQuery.of(context).size.height;
          final double screenWidth = MediaQuery.of(context).size.width;
          final double itemHeight =
              isLandscape ? screenHeight : screenHeight * 0.6;
          final double itemWidth =
              isLandscape ? screenWidth * 0.4 : screenWidth * 0.77;

          return CarouselSlider.builder(
            itemCount: snapshot!.length,
            options: CarouselOptions(
              height: itemHeight,
              aspectRatio: itemWidth / itemHeight,
              autoPlay: true,
              enlargeCenterPage: true,
              pageSnapping: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(seconds: 1),
            ),
            itemBuilder: (context, itemIndex, pageViewIndex) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (cxt) => DetailsScreen(
                        movieDetails: snapshot![itemIndex],
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: itemHeight,
                    width: itemWidth,
                    child: Image.network(
                      '${Constants.imagePath}${snapshot![itemIndex].posterPath}',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
