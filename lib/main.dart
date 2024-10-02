import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';

//Components
// import 'package:fitness/Pages/home.dart';
import 'package:fitness/Pages/recipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      // home: const HomePage(),
      home: const RecipePage(),
      // home: const Placeholder(),
    );
  }
}