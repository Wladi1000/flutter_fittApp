import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

//Components
import 'package:fitness/Pages/home.dart';
import 'package:fitness/Pages/recipe.dart';
import 'package:fitness/Pages/category_recipes_page.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Food Fitness App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: Modular.routerConfig,
      debugShowCheckedModeBanner: false,
    ); //added by extension
  }
}

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/',
        child: (context) => HomePage(),
        duration: const Duration(milliseconds: 1000));
    r.child('/recipe',
        child: (context) => RecipePage(recipe: r.args.data),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 1000));
    r.child('/category',
        child: (context) => CategoryRecipePage(categoria: r.args.data),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 1000));
  }
}
