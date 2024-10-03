import 'dart:math';
class Recipe{
  String name;
  String iconPath;
  String? level;
  String? duration;
  String? calorie;
  bool boxIsSelected = false;

  Recipe({ required this.name, required this.iconPath, required this.boxIsSelected, this.calorie, this.duration, this.level});

  static String _getRandomString(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
  }

  static List<Recipe> getRecipesList(){
    List<Recipe> recipeList = [];
    
    for (int i = 0; i < 20; i++) {
    recipeList.add(
      Recipe(
        name: _getRandomString(9),
        // iconPath: 'https://picsum.photos/seed/${Random(i)}/50/50',
        iconPath: 'assets/icons/blueberry-pancake.svg',
        level: 'Medium',
        duration: '30mins',
        calorie: '230kCal',
        boxIsSelected: true,
      ),
    );
  }
    return recipeList;
  }

}