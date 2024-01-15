import 'package:flutter/material.dart';
import 'package:moviesearch/screens/home_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moviesearch/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    token: prefs.getString('token'),
  ));
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({
    @required this.token,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Search App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      home: (token != null && !JwtDecoder.isExpired(token))
          ? HomeScreen(token: token,)
          : SignInPage(),
    );
  }
}
