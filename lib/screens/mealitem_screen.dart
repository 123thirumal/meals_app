import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/favouritelist_provider.dart';
import '../model/meal_model.dart';
import '../widget/metadata_widget.dart';

class MealItemScreen extends ConsumerStatefulWidget {
  const MealItemScreen(
      {super.key,
      required this.selectedMeal,});

  final Meal selectedMeal;


  @override
  ConsumerState<MealItemScreen> createState() {
    return _MealItemScreenState();
  }
}

class _MealItemScreenState extends ConsumerState<MealItemScreen> {

  @override
  Widget build(context) {

    final checkfor_presence=ref.watch(FavouriteListProvider).contains(widget.selectedMeal);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedMeal.title),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(FavouriteListProvider.notifier).toggleFavourite(widget.selectedMeal);
              if(checkfor_presence){
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 3),
                          content: Text('Meal is removed from Favourites'),
                      ),
                  );
                }
                else{
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 3),
                      content: Text('Meal is added to Favourites'),
                    ),
                  );
                }
                setState(() {});
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child,animation){
                return FadeTransition(
                  opacity: Tween(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(animation),
                  child: child,
                );
              },
              child: Icon(checkfor_presence?Icons.favorite:Icons.favorite_border,key: ValueKey(checkfor_presence),),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            child: Hero(
              tag: widget.selectedMeal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(widget.selectedMeal.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const Text('Ingredients'),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i in widget.selectedMeal.ingredients)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(i),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const Text('Info'),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: MetaDataWidget(
                                  specificIcon: Icons.timer,
                                  specificText:
                                      '${widget.selectedMeal.duration} min',
                                  reqFontsize: 20,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: MetaDataWidget(
                                  specificIcon: Icons.work,
                                  specificText:
                                      widget.selectedMeal.complexity.name,
                                  reqFontsize: 20,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: MetaDataWidget(
                                  specificIcon: Icons.currency_rupee,
                                  specificText:
                                      widget.selectedMeal.affordability.name,
                                  reqFontsize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text('Steps'),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i in widget.selectedMeal.steps)
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(i),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
