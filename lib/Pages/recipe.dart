// Dependencies
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

// Components
import 'package:fitness/Components/app_bar.dart';

// Models
import 'package:fitness/Models/recipe_model.dart';

// ignore: must_be_immutable
class RecipePage extends StatelessWidget {
  Recipe recipe;
  RecipePage({
    super.key,
    required this.recipe
  });

  static const lorem = '''
                  Velit esse do veniam dolor minim ullamco. Elit Lorem in est ullamco laboris eu nisi elit. Dolore id aute nostrud est eiusmod ipsum occaecat ad nostrud Lorem.

Cillum anim laboris laboris occaecat adipisicing. Sint incididunt fugiat aliqua labore elit commodo minim et. Magna quis elit commodo enim nostrud sit elit quis eiusmod ea qui ex. Labore exercitation enim nisi sunt et minim excepteur quis pariatur dolore incididunt elit consectetur. Fugiat velit ullamco aute ea et in magna id aliqua enim ipsum. Voluptate qui occaecat do nulla irure occaecat veniam Lorem eu id veniam est. Culpa officia laboris voluptate ad nulla.

Fugiat veniam commodo ullamco sunt aute non deserunt labore duis. Tempor aute incididunt deserunt pariatur et ad. Officia excepteur elit consequat laboris do. Nisi esse excepteur dolor officia incididunt aliquip elit culpa id. Ullamco magna minim consectetur dolor nisi magna labore enim. Cupidatat dolore veniam laborum mollit incididunt ea ad laborum ullamco voluptate in proident nulla aliquip. Duis in culpa fugiat culpa esse amet minim magna irure sint ea ipsum proident.
                  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar(context, 'Recipe'),
      body: ListView(
        // padding: EdgeInsets.all(7),
        children: [
          mainCard(),
          const SizedBox(height: 20,),
          recipeDetails(),
          const SizedBox(height: 20,),
          sendRecipeCard(),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }

  Padding recipeDetails() {
    return const Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recipe details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20,),
              Text(
                lorem,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 14),
              )
            ],
          ),
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
                      child:
                          SvgPicture.asset(recipe.iconPath),
                    )),
                Text(
                  recipe.name,
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
