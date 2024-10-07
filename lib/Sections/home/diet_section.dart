// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_modular/flutter_modular.dart';

// Modelos
import 'package:fitness/Models/diet_model.dart';
import 'package:fitness/Models/recipe_model.dart';

class DietSection extends HookWidget{

  final List<DietModel> diets;

  const DietSection({super.key, required this.diets});

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
