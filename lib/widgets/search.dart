import 'package:flutter/material.dart';
import 'package:movie_app/Screens/details.dart';
import 'package:movie_app/constants.dart';

class Seerch extends StatelessWidget {
  const Seerch({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => DetailsScreen(
                        movieDetails: snapshot.data[index],
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 200,
                    width: 140,
                    child: Image.network(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.contain,
                        '${Constants.imagePath}${snapshot.data[index].posterPath}'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
