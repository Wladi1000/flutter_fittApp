class CategoryModel{
  String name;
  String iconPath;

  CategoryModel({
    required this.name,
    required this.iconPath
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      iconPath: json['iconPath'],
    );
  }
}