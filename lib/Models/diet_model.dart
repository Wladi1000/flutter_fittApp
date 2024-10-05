import 'package:flutter/material.dart';
class DietModel{
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  Color boxColor;
  bool viewIsSelected;

  DietModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.boxColor,
    required this.viewIsSelected
  });

  factory DietModel.fromJson(Map<String, dynamic> json) {
    return DietModel(
      name: json['name'],
      iconPath: json['iconPath'],
      level: json['level'],
      duration: json['duration'],
      calorie: json['calorie'],
      boxColor: Color(json['boxColor']),
      viewIsSelected: json['viewIsSelected'],
    );
  }

  static List< DietModel > getDiets(){
    List < DietModel > diets = [];

    diets.add(
      DietModel(
        name: 'Honey Pancake',
        iconPath: 'assets/icons/honey-pancakes.svg',
        level: 'Easy',
        duration: '30mins',
        calorie: '180kCal',
        boxColor: const Color(0xff92a3fd),
        viewIsSelected: false
      )  
    );
    diets.add(
      DietModel(
        name: 'Canai Bread', 
        iconPath: 'assets/icons/canai-bread.svg', 
        level: 'Easy', 
        duration: '20mins', 
        calorie: '230kCal',
        boxColor: const Color(0xffc58bf2),
        viewIsSelected: false
      )
    );
    return diets;
  }
}