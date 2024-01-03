import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/meal_model.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>>{
  FavouriteMealsNotifier() : super([]);  //this is favoriteMeaList[]


  void toggleFavourite(Meal meal){
    if(state.contains(meal)){
      // for removing
      state=state.where((element){
        if(element.id==meal.id){
          return false;
        }
        else{
          return true;
        }
      }).toList();
    }
    else{
      //for adding
      state=[...state,meal];
    }
  }
}

final FavouriteListProvider = StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref){
  return FavouriteMealsNotifier();
});