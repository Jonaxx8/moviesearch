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
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<MovieProvider>(context, listen: false).fetchTopRatedMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieProvider>.value(
      value: Provider.of<MovieProvider>(context),
      child: Scaffold(
        body: Builder(
          builder: (context) {
            // Wrap with Builder to get a new context
            // and avoid calling Provider.of outside build method
            final movieProvider = Provider.of<MovieProvider>(context);

            return LazyLoadScrollView(
              onEndOfPage: () {
                if (!movieProvider.isLoading) {
                  // Use context.read to avoid triggering rebuild
                  context.read<MovieProvider>().fetchTopRatedMovies();
                }
              },
              child: MovieList(movies: movieProvider.movies),
            );
          },
        ),
      ),
    );
  }
}
