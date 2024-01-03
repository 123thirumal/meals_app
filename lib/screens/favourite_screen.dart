import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/screens/starting_screen.dart';
import 'package:transparent_image/transparent_image.dart';
import '../widget/metadata_widget.dart';
import 'filter_screen.dart';
import 'mealitem_screen.dart';
import 'package:meals_app/provider/favouritelist_provider.dart';


class FavouriteScreen extends ConsumerStatefulWidget {
  FavouriteScreen(
      {super.key,
      required this.selectScreen,});

  final void Function(int) selectScreen;


  @override
  ConsumerState<FavouriteScreen> createState() {
    return _FavouriteScreenState();
  }
}

class _FavouriteScreenState extends ConsumerState<FavouriteScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: (ref.watch(FavouriteListProvider).isEmpty)
          ? const Center(
              child: Text('Favourite is empty. Add meals to favourite'),
            )
          : ListView.builder(
              itemCount: ref.watch(FavouriteListProvider).length,
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
                        return MealItemScreen(
                            selectedMeal: ref.watch(FavouriteListProvider)[index],
                           );
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
                          child: FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),
                            image: NetworkImage(
                                ref.watch(FavouriteListProvider)[index].imageUrl),
                            fit: BoxFit.cover,
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
                                  ref.watch(FavouriteListProvider)[index].title,
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
                                      specificText:
                                          '${ref.watch(FavouriteListProvider)[index].duration} min',
                                      reqFontsize: 10,
                                    ),
                                    MetaDataWidget(
                                      specificIcon: Icons.work,
                                      specificText: ref.watch(FavouriteListProvider)[index]
                                          .complexity.name,
                                      reqFontsize: 10,
                                    ),
                                    MetaDataWidget(
                                      specificIcon: Icons.currency_rupee,
                                      specificText: ref.watch(FavouriteListProvider)[index]
                                          .affordability.name,
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          widget.selectScreen(index);
        },
        currentIndex: 1,
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
