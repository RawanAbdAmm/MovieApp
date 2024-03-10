import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/widgets/logo.dart';
import 'package:movie_app/cubit/favoritecubit.dart';
import 'package:movie_app/cubit/MovieListCubit/moviescubit.dart';
import 'package:movie_app/cubit/RatingCubit/rating_cubit.dart'; // Import your Cubit class

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieCubit>(
          create: (context) => MovieCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteMovieCubit(),
        ),
        BlocProvider<RatingCubit>(
          create: (context) => RatingCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutflix',
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white, fontSize: 24),
            bodyMedium: TextStyle(color: Colors.white, fontSize: 20),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 151, 22, 13),
          ).copyWith(background: Colors.black),
          fontFamily: GoogleFonts.ptSans().fontFamily,
          useMaterial3: true,
        ),
        home: const LogoScreen(),
      ),
    );
  }
}
