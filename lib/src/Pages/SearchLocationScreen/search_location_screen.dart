import 'package:flutter/material.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:provider/provider.dart';
import 'package:weather/src/Constant/api_urls.dart';
import 'package:weather/src/Constant/app_keys.dart';
import 'package:weather/src/Element/textfield_class.dart';
import 'package:weather/src/Style/colors.dart';
import 'package:weather/src/Utils/Notifier/search_location_notifier.dart';
import 'package:weather/src/app.dart';

SearchLocationScreen() => ChangeNotifierProvider<SearchLocationNotifier>(create: (_) => SearchLocationNotifier(), child: Builder(builder: (context) => SearchLocationScreenProvider(context: context)));

class SearchLocationScreenProvider extends StatelessWidget {
  SearchLocationScreenProvider({Key? key, required BuildContext context}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<SearchLocationNotifier>(
        builder: (context, state, child) {
          return SafeArea(
              top: false, bottom: false,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppButtonColors.background,
                  automaticallyImplyLeading: false,
                  title: const Text(SearchLocationScreenKey.searchLocation),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 25),
                  child: GooglePlacesAutoCompleteTextFormField(
                      textEditingController: searchController,
                      googleAPIKey: ApiUrls.googleApiKey,
                      debounceTime: 400,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: SearchLocationScreenKey.searchLocation,
                      ),
                      isLatLngRequired: true,
                      getPlaceDetailWithLatLng: (prediction) {
                        sharedPref.save("lti", prediction.lat);
                        sharedPref.save("lng", prediction.lng);
                        state.notifyListeners();
                      },
                      itmClick: (prediction) {
                        searchController.text = prediction.description!;
                        state.onTapSelectLocation(context);
                        state.notifyListeners();
                      }
                  ),
                ),
              ));
        }
    );
  }

}
