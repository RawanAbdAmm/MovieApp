import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/helper/api.dart';
import 'package:movie_app/models/movielist.dart';
import 'package:movie_app/widgets/movies.dart';
import 'package:movie_app/widgets/trending.dart';

class TopRated extends StatefulWidget {
  const TopRated({super.key});

  @override
  State<TopRated> createState() => _TopRated();
}

class _TopRated extends State<TopRated> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedgMovies;
  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedgMovies = Api().getTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          width: 50,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trending Movies ',
                style: GoogleFonts.aBeeZee(fontSize: 25),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                child: FutureBuilder(
                    future: trendingMovies,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return TrendingMovies(
                          snapshot: snapshot.data,
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
              ),
              const SizedBox(
                height: 32,
              ),

              Text(
                'UpComing Movies ',
                style: GoogleFonts.aBeeZee(fontSize: 25),
              ),
              SizedBox(
                child: FutureBuilder(
                    future: topRatedgMovies,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Movies(
                          movies: snapshot.data!,
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
              ),
              const SizedBox(
                height: 32,
              ),
              // const Movies(),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
