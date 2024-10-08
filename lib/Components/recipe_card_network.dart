// import 'package:flutter/material.dart';
// // ignore: depend_on_referenced_packages
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_modular/flutter_modular.dart';

// // Models
// import 'package:fitness/Models/recipe_model.dart';
// class RecipeCardNetwork extends StatelessWidget {

//   final Recipe recipe;

//   const RecipeCardNetwork({
//     super.key,
//     required this.recipe
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       decoration: BoxDecoration(
//           color: recipe.boxIsSelected
//               ? 
//               Colors.white
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: recipe.boxIsSelected
//               ? [
//                   BoxShadow(
//                       color: const Color(0xff1d1617).withOpacity(0.07),
//                       offset: const Offset(0, 10),
//                       blurRadius: 40,
//                       spreadRadius: 0)
//                 ]
//               : []),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Image.network(
//             recipe.iconPath,
//             width: 50,
//             height: 50,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 recipe.name,
//                 style: const TextStyle(
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                     fontSize: 16),
//               ),
//               Text(
//                 '${recipe.level} | ${recipe.duration} | ${recipe.calorie}',
//                 style: const TextStyle(
//                     color: Color(0xff7b6f72),
//                     fontSize: 13,
//                     fontWeight: FontWeight.w400),
//               ),
//             ],
//           ),
//           GestureDetector(
//             onTap: () => Modular.to.pushNamed('/recipe',
//                 arguments: Recipe(
//                     name: recipe.name,
//                     iconPath: recipe.iconPath,
//                     boxIsSelected: recipe.boxIsSelected,
//                     favorite: false,
//                     categoryId: recipe.categoryId),),
//             child: SvgPicture.asset(
//               'assets/icons/button.svg',
//               width: 30,
//               height: 30,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }