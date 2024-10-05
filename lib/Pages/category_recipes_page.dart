// Dependencies
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:fquery/fquery.dart';

// Models
import 'package:fitness/Models/recipe_model.dart';
import 'package:fitness/Models/category_model.dart';

// Components
import 'package:fitness/Components/app_bar.dart';
import 'package:fitness/Components/recipe_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Store
// import 'package:fitness/store/atoms.dart';

class CategoryRecipePage extends HookWidget {
  final CategoryModel categoria;
  const CategoryRecipePage({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {

    final futureRecipes = useMemoized(() async {
      final recipes = await rootBundle.loadString('assets/data/Recipes.json');
      final data = await json.decode(recipes) as List;
      final dataList = data.map((item) => Recipe.fromJson(item)).toList();
      return dataList;
    });

    final snapshot = useFuture(futureRecipes);
    // final recipes = snapshot.data?? [];
    final recipesSelected = [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar(context, categoria.name),
      body: snapshot.connectionState == ConnectionState.waiting
          ? const Center(child: CircularProgressIndicator())
          :
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
            itemCount: recipesSelected.length,
            padding: const EdgeInsets.only(left: 15, right: 15),
            itemBuilder: (context, index) {
          return RecipeCard(
              recipe: Recipe(
                  name: recipesSelected[index].name,
                  iconPath: recipesSelected[index].iconPath,
                  calorie: recipesSelected[index].calorie,
                  duration: recipesSelected[index].duration,
                  boxIsSelected: recipesSelected[index].boxIsSelected,
                  level: recipesSelected[index].level,
                  favorite: false,
                  categoryId: recipesSelected[index].categoryId
                )
          );
        },
      ),
    );
  }
}
