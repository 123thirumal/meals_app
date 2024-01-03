import 'package:flutter/material.dart';
import 'package:meals_app/provider/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterScreen extends ConsumerStatefulWidget{
  FilterScreen({super.key});


  @override
  ConsumerState<FilterScreen> createState(){
    return _FilterScreenState();
  }
}

class _FilterScreenState extends ConsumerState<FilterScreen>{


  @override
  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter',style: Theme.of(context).textTheme.titleLarge,),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: ref.watch(FilterProvider.notifier).filters[FilterOptions.glutenFree]!,
            onChanged: (isChecked){
                ref.watch(FilterProvider.notifier).filteringList(FilterOptions.glutenFree, isChecked);
              setState(() {});
            },
            title: Text('Gluten Free',style: Theme.of(context).textTheme.titleLarge,),
            contentPadding: const EdgeInsets.all(15),
          ),
          SwitchListTile(
            value: ref.watch(FilterProvider.notifier).filters[FilterOptions.vegan]!,
            onChanged: (isChecked){
              ref.watch(FilterProvider.notifier).filteringList(FilterOptions.vegan, isChecked);
              setState(() {});
            },
            title: Text('Vegan',style: Theme.of(context).textTheme.titleLarge,),
            contentPadding: const EdgeInsets.all(15),
          ),
          SwitchListTile(
            value: ref.watch(FilterProvider.notifier).filters[FilterOptions.vegetarian]!,
            onChanged: (isChecked){
              ref.watch(FilterProvider.notifier).filteringList(FilterOptions.vegetarian, isChecked);
              setState(() {});
            },
            title: Text('Vegetarian',style: Theme.of(context).textTheme.titleLarge,),
            contentPadding: const EdgeInsets.all(15),
          ),
          SwitchListTile(
            value: ref.watch(FilterProvider.notifier).filters[FilterOptions.lactoseFree]!,
            onChanged: (isChecked){
              ref.watch(FilterProvider.notifier).filteringList(FilterOptions.lactoseFree, isChecked);
              setState(() {});
            },
            title: Text('Lactose Free',style: Theme.of(context).textTheme.titleLarge,),
            contentPadding: const EdgeInsets.all(15),
          ),
        ],
      ),
    );
  }
}