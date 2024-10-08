// Dependencies
// import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:fquery/fquery.dart';
import 'package:flutter_modular/flutter_modular.dart';

// Modelos
import 'package:fitness/Models/diet_model.dart';
import 'package:fitness/Models/recipe_model.dart';

class DietSection extends HookWidget{

  final List<DietModel> diets;

  const DietSection({super.key, required this.diets});

  Future<Recipe> getRecipeById(int id) async{
    final recipe = await http.get(Uri.parse('https://dummyjson.com/recipes/$id'));
    if (recipe.statusCode == 200) {
      final data = jsonDecode(recipe.body);
      return Recipe.fromJson(data);
    } else {
      throw Exception('Failed to load recipe');
    }
  }


  @override
  Widget build(BuildContext context) {
  // useState
  final itemSelected = useState<int?>(null);

    final recipe1 = useQuery(['recipe1'], () => getRecipeById(1));
    // List<Recipe> recipes = [recipe1.data? null, recipe2.data?;

    if (recipe1.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (recipe1.isError) {
      return Center(child: Text(recipe1.error!.toString()));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Recomendation\nfor Diet',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          // color: Colors.blue,
          height: 240,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () =>  itemSelected.value = itemSelected.value != index? index : -1,
                child: Container(
                  width: 210,
                  decoration: BoxDecoration(
                      color: diets[index].boxColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(height: 150,width: 150,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),image: DecorationImage(image: NetworkImage(recipe1.data!.image), fit: BoxFit.fill))),
                      Column(
                        children: [
                          Text(
                            recipe1.data!.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                          Text(
                            '${recipe1.data!.difficulty} | ${recipe1.data!.cookTimeMinutes}mins | ${recipe1.data!.caloriesPerServing}Kcal',
                            style: const TextStyle(
                                color: Color(0xff7b6f72),
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Container(
                        height: 45,
                        width: 130,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              index == itemSelected.value
                                  ? const Color(0xff9dceff)
                                  : Colors.transparent,
                              index == itemSelected.value
                                  ? const Color(0xff92a3fd)
                                  : Colors.transparent
                            ]),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: TextButton(
                            onPressed: (){Modular.to.pushNamed('/recipe',
                                arguments: recipe1.data);},
                            child: Text(
                              'View',
                              style: TextStyle(
                                  color: index == itemSelected.value
                                      ? Colors.white
                                      : const Color(0xffc58bf2),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
