// Dependencies
import 'package:fitness/Sections/home/popular_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

// Modelos
import 'package:fitness/Models/diet_model.dart';
import 'package:fitness/Models/popular_model.dart';
// import 'package:fitness/Models/recipe_model.dart';

// Components
import 'package:fitness/Components/app_bar.dart';
// import 'package:fitness/Components/recipe_card.dart';

// Sections
import 'package:fitness/Sections/home/diet_section.dart';
import 'package:fitness/Sections/home/category_section.dart';

class HomePage extends HookWidget {
  HomePage({super.key});

  // final List<CategoryModel> categories = CategoryModel.getCategories();
  final List<DietModel> diets = DietModel.getDiets();
  final List<PopularDietsModel> popularModels =
      PopularDietsModel.getPopularDiets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Breakfast', false),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _searchField(),
          const SizedBox(
            height: 40,
          ),
          const CategoriesSection(),
          const SizedBox(
            height: 40,
          ),
          DietSection(diets: diets),
          const SizedBox(
            height: 40,
          ),
          const PopularSection(),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
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