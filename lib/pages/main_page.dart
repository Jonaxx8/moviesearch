import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:moviesearch/config.dart';

import '../models/movie.dart';
import '../widgets/movie_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Movie> movies = [];
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchTopRatedMovies();
  }

  Future<void> fetchTopRatedMovies() async {
    setState(() {
      isLoading = true;
    });
    const apiKey = movieApi;
    const baseUrl = 'https://api.themoviedb.org/3';
    final response = await http.get(Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey&page=$page'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> movieList = jsonResponse['results'];

      final List<Movie> newMovies = movieList.take(5).map((movieJson) {
        return Movie(
          name: movieJson['title'],
          year: movieJson['release_date'],
          rating: (movieJson['vote_average'] as num).toDouble(),
          posterUrl: 'https://image.tmdb.org/t/p/w500${movieJson['poster_path']}',
        );
      }).toList();

      setState(() {
        movies.addAll(newMovies);
        page++; // Increment page for the next lazy load
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Handle error
      print('Failed to load top-rated movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LazyLoadScrollView(
        onEndOfPage: () {
          if (!isLoading) {
            fetchTopRatedMovies();
          }
        },
        child: MovieList(movies: movies),
      ),
    );
  }
}
