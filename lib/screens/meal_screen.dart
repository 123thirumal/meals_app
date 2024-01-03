import 'package:flutter/material.dart';
import 'package:meals_app/screens/mealitem_screen.dart';
import 'package:meals_app/widget/metadata_widget.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/category_model.dart';
import '../model/meal_model.dart';

class MealScreen extends StatelessWidget {
  const MealScreen(
      {super.key, required this.selectedCategory, required this.meals,});

  MealScreen.forMeal(this.selectedCategory, List<Meal> a, {super.key})
      : meals = a.where((element) {
          if (element.categories.contains(selectedCategory.id)) {
            return true;
          } else {
            return false;
          }
        }).toList();

  final Category selectedCategory;
  final List<Meal> meals;



  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCategory.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return MealItemScreen(selectedMeal: meals[index]);
                }));
              },
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Hero(
                      tag: meals[index].id,
                      child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(meals[index].imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                      ),
                      child: Column(
                        children: [
                          Text(
                            meals[index].title,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MetaDataWidget(
                                specificIcon: Icons.timer,
                                specificText: '${meals[index].duration} min',
                                reqFontsize: 10,
                              ),
                              MetaDataWidget(
                                specificIcon: Icons.work,
                                specificText: meals[index].complexity.name,
                                reqFontsize: 10,
                              ),
                              MetaDataWidget(
                                specificIcon: Icons.currency_rupee,
                                specificText: meals[index].affordability.name,
                                reqFontsize: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
