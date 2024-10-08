// Dependencies
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fquery/fquery.dart';
import 'package:http/http.dart' as http;

// Models
import 'package:fitness/Models/recipe_model.dart';
import 'package:fitness/Models/category_model.dart';

// Components
import 'package:fitness/Components/app_bar.dart';
import 'package:fitness/Components/recipe_card.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Store
// import 'package:fitness/store/atoms.dart';

class CategoryRecipePage extends HookWidget {
  final CategoryModel categoria;
  const CategoryRecipePage({super.key, required this.categoria});

  Future<List<Recipe>> getRecipiesByTag() async {
    final recipes = await http
        .get(Uri.parse('https://dummyjson.com/recipes/tag/${categoria.name}'));
    if (recipes.statusCode == 200) {
      final data = jsonDecode(recipes.body);
      return (data['recipes'] as List).map((i) => Recipe.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipes = useQuery(['categoryRecipes'], getRecipiesByTag);
    // final recipes = snapshot.data?? [];
    if (recipes.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (recipes.isError) {
      return Center(child: Text(recipes.error!.toString()));
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(context, categoria.name),
        body: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
            itemCount: recipes.data!.length,
            padding: const EdgeInsets.only(left: 15, right: 15),
            itemBuilder: (context, index) {
              return RecipeCard(
                  recipe: recipes.data![index]
              );
            }
        )
      );
  }
}
