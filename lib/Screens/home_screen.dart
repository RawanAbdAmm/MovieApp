import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/cubit/favoritecubit.dart';
import 'package:movie_app/cubit/MovieListCubit/moviescubit.dart';
import 'package:movie_app/helper/api.dart';
import 'package:movie_app/models/movielist.dart';
import 'package:movie_app/widgets/movies.dart';
import 'package:movie_app/widgets/trending.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upComingMovies;
  late Future<List<Movie>> recommendation;
  late Future<List<Movie>> nowPlaying;
  Api api = Api();

  @override
  void initState() {
    super.initState();
    // Initialize future data fetching
    topRatedMovies = api.getTopRatedMovies();
    upComingMovies = api.getUpcomingMovies();
    recommendation = api.gettvShows();
    nowPlaying = api.getNowPlayingShows();
    context.read<MovieCubit>().getMovies();
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
          padding: const EdgeInsets.all(9.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                'Trending Movies ',
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: BlocBuilder<MovieCubit, MovieCubitState>(
                  builder: (context, state) {
                    if (state is MovieCubitLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieCubiSuccess) {
                      return TrendingMovies(snapshot: state.trendingMovie);
                    } else if (state is MovieCubiFailure) {
                      return Center(
                        child: Text(state.errMessage),
                      );
                    } else {
                      return Center(
                        child: Text('Unhandled state: $state'),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Top Rated Movies ',
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                child: BlocBuilder<MovieCubit, MovieCubitState>(
                  builder: (context, state) {
                    if (state is MovieCubitLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieCubiSuccess) {
                      return Movies(
                        movies: state
                            .topRatedMovie!, // Updated to use topRatedMovie from the state
                        onRate: (int movieId, double rating) {
                          api.addRatingToMovie(movieId, rating);
                        },
                      );
                    } else if (state is MovieCubiFailure) {
                      return Center(
                        child: Text(state.errMessage),
                      );
                    } else {
                      return Center(
                        child: Text('Unhandled state: $state'),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'Upcoming Movies ',
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                child: BlocBuilder<MovieCubit, MovieCubitState>(
                  builder: (context, state) {
                    if (state is MovieCubitLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieCubiSuccess) {
                      return Movies(movies: state.upcomingMovie ?? []);
                    } else if (state is MovieCubiFailure) {
                      return Center(
                        child: Text(state.errMessage),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Recommendation ',
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                child: BlocBuilder<FavoriteMovieCubit, List<Movie>>(
                  builder: (context, state) {
                    return FutureBuilder(
                      future: recommendation,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Movies(movies: snapshot.data!);
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Now Playing ',
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                child: BlocBuilder<MovieCubit, MovieCubitState>(
                  builder: (context, state) {
                    if (state is MovieCubitLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieCubiSuccess) {
                      return Movies(movies: state.topRatedMovie ?? []);
                    } else if (state is MovieCubiFailure) {
                      return Center(
                        child: Text(state.errMessage),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
