import 'dart:convert';
import 'dart:developer';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movielist.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.themoviedb.org/3/';
var key = '?api_key=${Constants.apiKey}';
late String endPoint;

class Api {
  static const trendingUrl =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}";
  static const topRatedUrl =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}";
  static const upComingUrl =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}";
  static const tvshowsUrl =
      "https://api.themoviedb.org/3/trending/tv/day?api_key=${Constants.apiKey}";
  static const recommendationUrl =
      "https://api.themoviedb.org/3/movie/13/recommendations?api_key=${Constants.apiKey}";
  static const nowPlayingUrl =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=${Constants.apiKey}";
  static const searchurl = "https://api.themoviedb.org/3/search/multi?";

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(trendingUrl));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body)['results'] as List;
      // print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Something went Wrong!");
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(topRatedUrl));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body)['results'] as List;
      // print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Something went Wrong!");
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(upComingUrl));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body)['results'] as List;
      // print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Something went Wrong!");
    }
  }

  Future<List<Movie>> gettvShows() async {
    final response = await http.get(Uri.parse(recommendationUrl));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body)['results'] as List;
      // print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Something went Wrong!");
    }
  }

  Future<List<Movie>> getNowPlayingShows() async {
    final response = await http.get(Uri.parse(nowPlayingUrl));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body)['results'] as List;
      // print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Something went Wrong!");
    }
  }

  Future<Movie> getPopularMovies() async {
    endPoint = 'movie/popular';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url), headers: {});
    if (response.statusCode == 200) {
      log('success');
      return Movie.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<List<Movie>> getSearchedMovie(String searchText) async {
    endPoint = 'search/movie?query=$searchText';
    final url = '$baseUrl$endPoint';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc'
      });
      if (response.statusCode == 200) {
        final List<Movie> movies = [];
        final List<dynamic> results = jsonDecode(response.body)['results'];

        for (var result in results) {
          movies.add(Movie.fromJson(result));
        }

        return movies;
      } else {
        throw Exception('Failed to load search movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> addRatingToMovie(int movieId, double rating) async {
    final String apiUrl =
        'https://api.themoviedb.org/3/movie/$movieId/rating'; // Use movieId parameter

    final Map<String, dynamic> requestBody = {
      'value': rating.toString(),
    };

    final Uri uri = Uri.parse('$apiUrl?api_key=${Constants.apiKey}');

    try {
      final http.Response response = await http.post(
        uri,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        print('Rating added successfully!');
      } else {
        print('Failed to add rating: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('Error adding rating: $e');
    }
  }

  Future<void> deleteRatingFromMovie(int movieId) async {
    final String apiUrl =
        'https://api.themoviedb.org/3/movie/$movieId/rating'; // Use movieId parameter

    final Uri uri = Uri.parse('$apiUrl?api_key=${Constants.apiKey}');

    try {
      final http.Response response = await http.delete(
        uri,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        print('Rating deleted successfully!');
      } else {
        print('Failed to delete rating: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('Error deleting rating: $e');
    }
  }
}
