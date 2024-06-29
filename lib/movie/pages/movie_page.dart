import 'package:duplikat_applikasi/movie/components/movie_disover_component.dart';
import 'package:duplikat_applikasi/movie/components/movie_now_playing_component.dart';
import 'package:duplikat_applikasi/movie/components/movie_top_rated_component.dart';
import 'package:duplikat_applikasi/movie/pages/movie_search_page.dart';
import 'package:flutter/material.dart';

import 'movie_pagination_page.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Row(
                mainAxisSize: MainAxisSize.min,
                children:[
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: CircleAvatar(
                  //     backgroundColor: Colors.transparent,
                  //     child: Image.asset(
                  //       'assets/images/logo.png',
                  //       ),
                  //   ),
                  // ),
                  Text('Home'),
                ],
              ),
              actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => showSearch(
                  context: context,
                  delegate: MovieSearchPage(),
                ),
              ),
            ],
            floating: true,
            snap: true,
            centerTitle: true,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          _WidgetTitle(
            title: 'Discover Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MoviePaginationPage(
                    type: TypeMovie.discover,
                  ),
                ),
              );
            },
          ),
          const MovieDisoverComponent(),
          _WidgetTitle(
            title: 'Top Rated Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MoviePaginationPage(
                    type: TypeMovie.topRated,
                  ),
                ),
              );
            },
          ),
          const MovieTopRatedComponent(),
          _WidgetTitle(
            title: 'Now Playing Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MoviePaginationPage(
                    type: TypeMovie.nowPlaying,
                  ),
                ),
              );
            },
          ),
          const MovieNowPlayingComponent(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
        ],
      ),
    );
  }
}

class _WidgetTitle extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const _WidgetTitle({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                shape: const StadiumBorder(),
                side: const BorderSide(
                  color: Colors.white,
                ),
              ),
              child: const Text(
                'All',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}