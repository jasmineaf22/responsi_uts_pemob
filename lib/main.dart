import 'package:flutter/material.dart';
import '/helpers/user_info.dart';
import '/ui/login_page.dart';
import '/ui/penginapan_page.dart'; // Updated to use penginapan_page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const PenginapanPage(); // Updated to use PenginapanPage
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Manajemen Pariwisata',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial', // Set the font family to Arial
        primarySwatch: Colors.red, // Primary color
        brightness: Brightness.light, // Set brightness to light
        appBarTheme: AppBarTheme(
          color: Colors.red[400], // Light red color for the app bar
        ),
        scaffoldBackgroundColor: Colors.red[200],
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Default text color for body
          bodySmall: TextStyle(color: Colors.white), // Default text color for small body text
        ),
      ),
      home: page, // Use the login state to determine the home page
    );
  }
}
