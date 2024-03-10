import 'package:flutter/material.dart';
import 'package:movie_app/Screens/favorite_movies.dart';
import 'package:movie_app/Screens/home_screen.dart';
import 'package:movie_app/Screens/search.dart';
import 'package:movie_app/Screens/top_rated.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: Container(
            color: Colors.black,
            height: 70,
            child: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                    size: 32,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.search_rounded,
                    size: 32,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.star_rate_outlined,
                    size: 32,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.favorite,
                    size: 32,
                  ),
                ),
              ],
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Color(0xff999999),
            ),
          ),
          body: const TabBarView(children: [
            HomeScreen(),
            SearchMovie(),
            TopRated(),
            FavoritePage(),
          ]),
        ));
  }
}
