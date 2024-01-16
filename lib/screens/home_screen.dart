import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:moviesearch/pages/favorite_page.dart';
import 'package:moviesearch/pages/main_page.dart';
import 'package:moviesearch/pages/search_page.dart';
import 'package:moviesearch/widgets/navbar.dart';

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
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
  }

  void _handleLogout() {
    // Perform logout logic here
    // For example, you can navigate to the login screen and clear user data
    Navigator.pushReplacementNamed(
        context, '/login'); // Replace '/login' with your actual login route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Moviesearch'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _handleLogout,
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          children: const [
            MainPage(),
            SearchPage(),
            FavPage(),
          ],
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        bottomNavigationBar: NavBar(
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease,
              );
            });
          },
        ));
  }
}
