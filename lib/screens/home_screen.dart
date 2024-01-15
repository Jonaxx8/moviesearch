import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:movie_search_app/screens/movie_details_screen.dart';
// import 'package:movie_search_app/widgets/movie_list.dart';

class HomeScreen extends StatefulWidget {
  final token;
  const HomeScreen({
    Key? key,
    this.token,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: const Scaffold(),
    );
  }
}
