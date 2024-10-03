// Dependencies
import 'package:flutter/material.dart';

//Models
import 'package:fitness/Models/recipe_model.dart';

// Components
import 'package:fitness/Components/app_bar.dart';
import 'package:fitness/Components/recipe_card.dart';

class CategoryRecipePage extends StatelessWidget {
  final String categoria;
  CategoryRecipePage({super.key, required this.categoria});

  final List<Recipe> recipesSelected = Recipe.getRecipesList();

  @override
  Widget build(BuildContext context) {
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
                level: recipesSelected[index].level
              ),
            
          );
        },
      ),
    );
  }
}
