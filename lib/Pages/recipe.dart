// Dependencies
import 'package:fitness/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Components
import 'package:fitness/Components/app_bar.dart';

// Models
import 'package:fitness/Models/recipe_model.dart';

// Store
import 'package:fitness/store/atoms.dart';

// ignore: must_be_immutable
class RecipePage extends HookWidget {
  Recipe recipe;
  RecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final favorite = useAtomState$(favoriteRecipe.state);

    setRecipeFavorite() {
      favoriteRecipe.set(!favorite);
    }

    // final favorites = useAtomState$(favoriteRecipesAtomFactory.state);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar(context, 'Recipe'),
      body: Stack(children: [
        ListView(
          // padding: EdgeInsets.all(7),
          children: [
            mainCard(),
            const SizedBox(
              height: 20,
            ),
            recipeDetails(),
            const SizedBox(
              height: 20,
            ),
            sendRecipeCard(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
        Positioned(
            bottom: 15,
            right: 15,
            child: GestureDetector(
              onTap: () => setRecipeFavorite(),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF5FF),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: favorite
                      ? const Icon(
                          Icons.favorite,
                          color: Color(0xFFFF79D9),
                          size: 50,
                        )
                      : const Icon(
                          Icons.favorite_border_outlined,
                          color: Color(0xFFFF79D9),
                          size: 50,
                        ),
                ),
              ),
            ))
      ]),
    );
  }

  Padding recipeDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Recipe details:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Ingredients:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...recipe.ingredients.map((e) => Row(
              children: [
                const Icon(Icons.check),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  e,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 14),
                ),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Instructions:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Column(
          children: [
            ...recipe.instructions.map((e) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.circle_outlined, size: 10,),
                const SizedBox(width: 10,),
                Expanded(
                  child: Text(
                    e,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ),
              ],
            ))
          ],
        )
      ]),
    );
  }

  Padding sendRecipeCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          // width: 400,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Save This Recipe!',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const Text(
                  "We'll email this post to you, so you can come back to it later!",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Email Addres',
                        hintStyle: const TextStyle(
                            color: Color(0x88000000), fontSize: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none)),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(value: true, onChanged: null),
                    Text('I agrees to be sent email',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14)),
                  ],
                ),
                const IconButton(
                  onPressed: null,
                  icon: Icon(Icons.email_outlined),
                  style: ButtonStyle(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding mainCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: const Color(0xFF407AB7).withOpacity(.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(recipe.image),
                    )),
                Text(
                  !recipe.favorite ? recipe.name : "soy favorito",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
