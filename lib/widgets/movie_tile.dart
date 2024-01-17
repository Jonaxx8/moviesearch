import 'package:flutter/material.dart';
import 'package:moviesearch/util/custom_snackbar.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../provider/movie_provider.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Image.network(
            movie.posterUrl,
            width: double.infinity,
            height: 150.0,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: IconButton(
              icon: Icon(
                movie.isLiked ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () {
                final movieProvider =
                    Provider.of<MovieProvider>(context, listen: false);
                movieProvider.toggleLike(movie);
                final snackBarMessage = movie.isLiked
                    ? 'Added to favorites'
                    : 'Removed from favorites';
                final snackBarColor =
                    movie.isLiked ? Colors.green : Colors.red;
                showCustomSnackBar(context, snackBarMessage, snackBarColor);
              },
            ),
          ),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            right: 8.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Year: ${movie.year}',
                  style: const TextStyle(color: Colors.white60),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'IMDb Rating: ${movie.rating}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
