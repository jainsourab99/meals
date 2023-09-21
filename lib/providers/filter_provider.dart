import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/filters.dart';

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier() 
  : super({
    Filter.glutenFree: false,
        Filter.lactosFree: false,
    Filter.vegetration: false,
    Filter.vegan: false,
  });

  void setFilters(Map<Filter, bool> chosenFilter) {
    state = chosenFilter;
  }
  void setFilter(Filter filter, bool isActive) {
   // state[filter] = isActive;
   state = {
    ...state,
    filter: isActive,
   };
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) => FilterNotifier());

final filterMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilter = ref.watch(filterProvider);
  return meals.where((meal) {
      if (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilter[Filter.lactosFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilter[Filter.vegetration]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
});