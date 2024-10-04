// import 'package:asp/asp.dart';
import 'package:fitness/Models/recipe_model.dart';
import 'atoms.dart';

AtomFactory<List<Recipe>> favoriteRecipesAtomFactory = AtomFactory<List<Recipe>>(
  'favoritesRecipes',
  [],
);