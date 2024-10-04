class CategoryModel{
  int id;
  String name;
  String iconPath;

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconPath
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      iconPath: json['iconPath'],
    );
  }
}