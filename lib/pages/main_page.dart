import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import '../provider/movie_provider.dart';
import '../widgets/movie_list.dart';
import '../widgets/sort_dropdown.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

// class _MainPageState extends State<MainPage> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       Provider.of<MovieProvider>(context, listen: false).fetchTopRatedMovies();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<MovieProvider>.value(
//       value: Provider.of<MovieProvider>(context),
//       child: Scaffold(
//         body: Builder(
//           builder: (context) {
//             final movieProvider = Provider.of<MovieProvider>(context);

//             return LazyLoadScrollView(
//               onEndOfPage: () {
//                 if (!movieProvider.isLoading) {
//                   context.read<MovieProvider>().fetchTopRatedMovies();
//                 }
//               },
//               child: MovieList(movies: movieProvider.movies),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

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
        body: Column(
          children: [
            Expanded(
              child: LazyLoadScrollView(
                onEndOfPage: () {
                  final movieProvider = context.read<MovieProvider>();
                  if (!movieProvider.isLoading) {
                    movieProvider.fetchTopRatedMovies();
                  }
                },
                child: MovieList(movies: context.watch<MovieProvider>().movies),
              ),
            ),
          ],
        ),
      ),
    );
  }
}