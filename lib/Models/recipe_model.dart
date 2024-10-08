class Recipe {
  int id;
  String name;
  List<String> ingredients;
  List<String> instructions;
  int prepTimeMinutes;
  int cookTimeMinutes;
  int servings;
  String difficulty;
  int caloriesPerServing;
  List<String> tags;
  String image;
  bool favorite = false;

  Recipe(
      {required this.id,
      required this.name,
      required this.ingredients,
      required this.instructions,
      required this.prepTimeMinutes,
      required this.cookTimeMinutes,
      required this.servings,
      required this.difficulty,
      required this.caloriesPerServing,
      required this.tags,
      required this.image});

  static Recipe fromJson(Map<String, dynamic> json) => Recipe(
      id: json['id'],
      name: json['name'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: List<String>.from(json['instructions']),
      prepTimeMinutes: json['prepTimeMinutes'],
      cookTimeMinutes: json['cookTimeMinutes'],
      servings: json['servings'],
      difficulty: json['difficulty'],
      caloriesPerServing: json['caloriesPerServing'],
      tags: List<String>.from(json['tags']),
      image: json['image']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'ingredients': ingredients,
        'instructions': instructions,
        'prepTimeMinutes': prepTimeMinutes,
        'cookTimeMinutes': cookTimeMinutes,
        'servings': servings,
        'difficulty': difficulty,
        'caloriesPerServing': caloriesPerServing,
        'tags': tags,
        'image': image
      };
}
