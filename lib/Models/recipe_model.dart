class Recipe{
  String name;
  String iconPath;
  String? level;
  String? duration;
  String? calorie;
  bool boxIsSelected = false;

  Recipe({ required this.name, required this.iconPath, required this.boxIsSelected, this.calorie, this.duration, this.level});
}