class Recipe {
  String name;
  String iconPath;
  String? level;
  String? duration;
  String? calorie;
  int categoryId;
  bool boxIsSelected = false;
  bool favorite = false;

  Recipe(
      {required this.name,
      required this.iconPath,
      required this.boxIsSelected,
      this.calorie,
      this.duration,
      this.level,
      required this.favorite,
      required this.categoryId});

  static Recipe fromJson(json) => Recipe(
      name: json['name'],
      iconPath: json['iconPath'],
      boxIsSelected: json['boxIsSelected'],
      calorie: json['calorie'],
      duration: json['duration'],
      level: json['level'],
      favorite: json['favorite'],
      categoryId: json['categoryId']);
}