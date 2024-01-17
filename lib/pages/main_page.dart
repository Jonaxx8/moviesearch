import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import '../provider/movie_provider.dart';
import '../widgets/movie_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Fetch top-rated movies when the page is initialized
    Future.delayed(Duration.zero, () {
      Provider.of<MovieProvider>(context, listen: false).fetchTopRatedMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LazyLoadScrollView(
        onEndOfPage: () {
          // Fetch more top-rated movies when reaching the end of the page
          if (!isLoading) {
            Provider.of<MovieProvider>(context, listen: false)
                .fetchTopRatedMovies();
          }
        },
        child: Consumer<MovieProvider>(
          builder: (context, movieProvider, child) {
            return MovieList(movies: movieProvider.movies);
          },
        ),
      ),
    );
  }
}
