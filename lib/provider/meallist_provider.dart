import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/meal_data.dart';

final mealListProvider = Provider((ref){
  return dummyMeals;
});