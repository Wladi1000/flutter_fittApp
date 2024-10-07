// Dependencies
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_modular/flutter_modular.dart';

// Modelos
import 'package:fitness/Models/category_model.dart';

class CategoriesSection extends HookWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {

    final dietsTags = useState<List<String>>([]);
    final dietCategory = useState<List<CategoryModel>>([]);

    Future<void> fetchData() async {
      final response = await http.get(Uri.parse('https://dummyjson.com/recipes/tags'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        dietsTags.value = (data as List).map((i) => i.toString()).toList();
      } else {
        throw Exception('Failed to load data');
      }
      int i = 0;
      for (var e in dietsTags.value) {

        final imageResponse = await http.get(Uri.parse('https://dummyjson.com/recipes/tag/$e?limit=1&select=image'));

        if (imageResponse.statusCode == 200) {
          final data = json.decode(imageResponse.body);
          String images;
          images = ((data['recipes'] as List).map((recipe) => recipe['image'].toString()).toList())[0];
          dietCategory.value = [
            ...dietCategory.value,
            CategoryModel(
              id: i,
              name: dietsTags.value[i],
              image: images
            )
          ];
          i++;
        } else {
          throw Exception('Failed to load data');
        }
      }
    }

    useEffect(() {
      fetchData();
      return;
    }, []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
            child: Row(
            children: [
              const Text(
              'Category',
              style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 20), // Add separation of 20px
              // dietCategory.value.length < dietsTags.value.length
              dietCategory.value.length < dietsTags.value.length?
              const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child:CircularProgressIndicator(strokeWidth: 2),
                ),
                )
              : const SizedBox(),
            ],
            ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 120,
          child: dietCategory.value.isEmpty
          ? const Center(child: CircularProgressIndicator())
          :
          _categoryList(dietCategory),
        )
      ],
    );
  }

  ListView _categoryList(ValueNotifier<List<CategoryModel>> dietCategory) {
    return ListView.separated(
          itemCount: dietCategory.value.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20, right: 20),
          separatorBuilder: (context, index) => const SizedBox(
            width: 25,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Modular.to.pushNamed(
                '/category',
                arguments: dietCategory.value[index]
              ),
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: dietCategory.value.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        :
                        Image.network(
                            dietCategory.value[index].image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      dietCategory.value[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                  ],
                ),
              ), 
            );
          },
        );
  }
}
