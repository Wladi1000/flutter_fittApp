import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Components
import 'package:fitness/Components/app_bar.dart';


class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar(context, 'Recipe'),
    );
  }

}

