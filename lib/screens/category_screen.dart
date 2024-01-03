import 'package:flutter/material.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meal_screen.dart';
import '../data/category_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/filters_provider.dart';


class CategoryScreen extends ConsumerStatefulWidget {
  CategoryScreen({super.key,
    required this.selectScreen,});

  final void Function(int) selectScreen;




  @override
  ConsumerState<CategoryScreen> createState() {
    return _CategoryScreenState();
  }

}

class _CategoryScreenState extends ConsumerState<CategoryScreen>{

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meals App',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          for (var i in availableCategories)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) {
                        return MealScreen.forMeal(
                            i, ref.read(FilterProvider));
                      },
                    ),
                  );
                },
                splashColor: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        i.color.withOpacity(0.55),
                        i.color.withOpacity(0.91)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(i.title),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          widget.selectScreen(index);
        },
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.no_meals_outlined), label: 'Category'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourites'),
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondaryContainer,
                      Theme.of(context).colorScheme.primaryContainer
                    ],
                    end: Alignment.bottomLeft,
                    begin: Alignment.topRight,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Cooking Up!',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 30),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.dining),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.filter_alt_outlined),
              title: Text(
                'Filter',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return FilterScreen();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
