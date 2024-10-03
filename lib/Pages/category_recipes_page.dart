// Dependencies
import 'package:fitness/store/store.dart';
import 'package:flutter/material.dart';

//Models
import 'package:fitness/Models/recipe_model.dart';

// Components
import 'package:fitness/Components/app_bar.dart';
import 'package:fitness/Components/recipe_card.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Store
import 'package:fitness/store/atoms.dart';

class CategoryRecipePage extends HookWidget {
  final String categoria;
  const CategoryRecipePage({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    final List<Recipe> recipesSelected = useAtomState$(favoriteRecipesAtomFactory.state);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar(context, categoria),
      body: ListView.separated(
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
                favorite: false
              )
          );
        },
      ),
    );
  }
}
