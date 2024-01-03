import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/meal_data.dart';
import '../model/meal_model.dart';

enum FilterOptions  {glutenFree,vegan,vegetarian,lactoseFree}

class FilterNotifier extends StateNotifier<List<Meal>>{
  FilterNotifier() : super(dummyMeals);

  Map<FilterOptions, bool> filters={
    FilterOptions.glutenFree:false,
    FilterOptions.vegetarian:false,
    FilterOptions.vegan:false,
    FilterOptions.lactoseFree:false
  };

  void filteringList(FilterOptions filterType,bool isChecked){
    filters[filterType]=isChecked;
    state=dummyMeals.where((item){
      if(filters[FilterOptions.glutenFree]!&&!item.isGlutenFree){
        return false;
      }
      if(filters[FilterOptions.vegetarian]!&&!item.isVegetarian){
        return false;
      }
      if(filters[FilterOptions.vegan]!&&!item.isVegan){
        return false;
      }
      if(filters[FilterOptions.lactoseFree]!&&!item.isLactoseFree){
        return false;
      }
      return true;
    }).toList();
  }
}

final FilterProvider = StateNotifierProvider<FilterNotifier,List<Meal>>((ref){
  return FilterNotifier();
});