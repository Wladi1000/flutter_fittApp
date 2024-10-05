import 'dart:convert';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_modular/flutter_modular.dart';

// Modelos
import 'package:fitness/Models/category_model.dart';
import 'package:fitness/Models/diet_model.dart';
import 'package:fitness/Models/popular_model.dart';
import 'package:fitness/Models/recipe_model.dart';

// Components
import 'package:fitness/Components/app_bar.dart';
import 'package:fitness/Components/recipe_card.dart';

class HomePage extends HookWidget {

  HomePage({super.key});

  // final List<CategoryModel> categories = CategoryModel.getCategories();
  final List<DietModel> diets = DietModel.getDiets();
  final List<PopularDietsModel> popularModels = PopularDietsModel.getPopularDiets();

  @override
  Widget build(BuildContext context){

    final diets = useState<List<DietModel>>([]);
    // final popularModels = useState<List<PopularDietsModel>>([]);

    return Scaffold(
      appBar: myAppBar(context, 'Breakfast'),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _searchField(),
          const SizedBox(height: 40,),
          const _CategoriesSection(),
          const SizedBox(height: 40,),
          _DietSection(diets: diets.value,),
          const SizedBox(height: 40,),
          _popularSection(),
          const SizedBox(height: 40,),
        ],
      ),
    );
  }

  Column _popularSection() {
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
      ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
        itemCount: popularModels.length,
        padding: const EdgeInsets.only(left: 15, right: 15),
        itemBuilder: (context, index) {
          return RecipeCard(recipe: Recipe(
            name: popularModels[index].name, 
            iconPath: popularModels[index].iconPath, 
            calorie: popularModels[index].calorie, 
            duration: popularModels[index].duration, 
            boxIsSelected: popularModels[index].boxIsSelected,
            level: popularModels[index].level,
            favorite: false,
            categoryId: 0),
          );
        },
      )
    ]);
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color(0xff1d1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0)
      ]),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Search Pacake',
            hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset('assets/icons/Search.svg'),
            ),
            suffixIcon: SizedBox(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const VerticalDivider(
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                      thickness: .1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/icons/Filter.svg'),
                    ),
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none)),
      ),
    );
  }
}

class _CategoriesSection extends HookWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context) {

    final dietsTags = useState<List<String>>([]);
    final dietCategory = useState<List<CategoryModel>>([]);

    Future<void> fetchData() async {
      final response = await http.get(Uri.parse('https://dummyjson.com/recipes/tags'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        dietsTags.value = (data as List).map((i) => i.toString()).toList();
      } else {
        throw Exception('Failed to load data');
      }
      int i = 0;
      for (var e in dietsTags.value) {

        final imageResponse = await http.get(Uri.parse('https://dummyjson.com/recipes/tag/$e?limit=1&select=image'));

        if (imageResponse.statusCode == 200) {
          final data = json.decode(imageResponse.body);
          String images;
          images = ((data['recipes'] as List).map((recipe) => recipe['image'].toString()).toList())[0];
          dietCategory.value = [
            ...dietCategory.value,
            CategoryModel(
              id: i,
              name: dietsTags.value[i],
              image: images
            )
          ];
          i++;
        } else {
          throw Exception('Failed to load data');
        }
      }
    }

    useEffect(() {
      fetchData();
      return;
    }, []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
            child: Row(
            children: [
              const Text(
              'Category',
              style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 20), // Add separation of 20px
              // dietCategory.value.length < dietsTags.value.length
              dietCategory.value.length < dietsTags.value.length?
              const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child:CircularProgressIndicator(strokeWidth: 2),
                ),
                )
              : const SizedBox(),
            ],
            ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 120,
          child: dietCategory.value.isEmpty
          ? const Center(child: CircularProgressIndicator())
          :
          ListView.separated(
            itemCount: dietCategory.value.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Modular.to.pushNamed(
                  '/category',
                  arguments: dietCategory.value[index]
                ),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: dietCategory.value.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          :
                          Image.network(
                              dietCategory.value[index].image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(
                        dietCategory.value[index].name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14),
                      ),
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


class _DietSection extends HookWidget{

  final List<DietModel> diets;

  const _DietSection({required this.diets});

  @override
  Widget build(BuildContext context) {
  // useState
  final itemSelected = useState<int?>(null);

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
                      SvgPicture.asset(diets[index].iconPath),
                      Column(
                        children: [
                          Text(
                            diets[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                          Text(
                            '${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}',
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
                                arguments: Recipe(
                                    name: diets[index].name,
                                    iconPath: diets[index].iconPath,
                                    boxIsSelected: diets[index].viewIsSelected,
                                    favorite: false,
                                    categoryId: 0));
                                    itemSelected.value = index;
                                    },
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
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemCount: diets.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
          ),
        )
      ],
    );
  }
}
