import 'package:flutter/material.dart';
import 'package:weather/src/Element/textfield_class.dart';
import 'package:weather/src/Pages/HomeScreen/home_screen.dart';

class SearchLocationNotifier extends ChangeNotifier {

  onTapSelectLocation(BuildContext context, ){
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(isSearch: true)));
    searchController.clear();
    notifyListeners();
  }

}
