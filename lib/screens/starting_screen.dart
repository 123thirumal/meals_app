import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/favourite_screen.dart';




class StartingScreen extends StatefulWidget{
  StartingScreen({super.key});

  int _currentScreenInd=0;



  @override
  State<StartingScreen> createState(){
    return _StartingScreenState();
  }
}

class _StartingScreenState extends State<StartingScreen>{



  void _selectedIndex(int index){
    setState(() {
      widget._currentScreenInd=index;
    });
  }



  @override
  Widget build(context){


    if(widget._currentScreenInd==0){
      return CategoryScreen(selectScreen: _selectedIndex,);
    }
    else{
      return FavouriteScreen(selectScreen: _selectedIndex,);
    }
  }

}