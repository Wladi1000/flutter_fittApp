// Dependencies
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:http/http.dart' as http;

// Models
import 'package:fitness/Models/recipe_model.dart';

// Components
import 'package:fitness/Components/recipe_card.dart';

class PopularSection extends HookWidget {
  const PopularSection({
    super.key,
  });

  Future<List<Recipe>> getPopularRecipiesByTag() async {
    final recipes =
        await http.get(Uri.parse('https://dummyjson.com/recipes/tag/Stir-fry'));
    if (recipes.statusCode == 200) {
      final data = jsonDecode(recipes.body);
      return (data['recipes'] as List)
          .map((i) => Recipe.fromJson(i))
          .toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipes = useQuery(['PopularRecipes'], getPopularRecipiesByTag);

    if (recipes.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (recipes.isError) {
      return Center(child: Text(recipes.error!.toString()));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text(
          'Popular',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      ...recipes.data!.map((recipe) => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        child: RecipeCard(recipe: recipe),
      ))
    ]);
  }
}
