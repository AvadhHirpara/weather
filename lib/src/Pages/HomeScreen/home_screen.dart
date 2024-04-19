import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/src/Constant/api_urls.dart';
import 'package:weather/src/Constant/app_keys.dart';
import 'package:weather/src/Element/padding_class.dart';
import 'package:weather/src/Pages/SearchLocationScreen/search_location_screen.dart';
import 'package:weather/src/Style/colors.dart';
import 'package:weather/src/Utils/Helper/page_route.dart';
import 'package:weather/src/Utils/Notifier/home_notiffier.dart';

HomeScreen({ bool? isSearch = false}) => ChangeNotifierProvider<HomeNotifier>(create: (_) => HomeNotifier(), child: Builder(builder: (context) => HomeScreenProvider(context: context, isSearch: isSearch)));

class HomeScreenProvider extends StatefulWidget {

  bool? isSearch;

  HomeScreenProvider({Key? key, required BuildContext context, this.isSearch = false}) : super(key: key);

  @override
  State<HomeScreenProvider> createState() => _HomeScreenProviderState();
}

class _HomeScreenProviderState extends State<HomeScreenProvider> {
  @override
  void initState() {
    var state = Provider.of<HomeNotifier>(context, listen: false);
    state.initStates(context, isSearch: widget.isSearch ?? false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(builder: (context, state, child) {
      return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppButtonColors.background,
              automaticallyImplyLeading: false,
              title: const Text(HomeScreenKey.homeScreen),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: state.weatherData != null ?  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () async{
                            push(context, SearchLocationScreen());
                          },
                          child: const Icon(Icons.search)),
                    ),
                    paddingTop(10),
                    Center(
                        child: Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppBgColors.black),
                            child: Image.network('${ApiUrls.imageUrl}${state.weatherData?[HomeResponseKey.weather][0][HomeResponseKey.icon]}.png', color: AppIconColors.white))),
                    paddingTop(10),
                    Center(child: Text(state.weatherData?[HomeResponseKey.weather][0][HomeResponseKey.main] ?? '')),
                    paddingTop(25),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text(HomeScreenKey.temperature),
                                  Text(state.isCelsius ? '${state.weatherData?[HomeResponseKey.main][HomeResponseKey.temp]}°C' : '${state.fahrenheit}°f'),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text(HomeScreenKey.location),
                                  Text('${state.weatherData?[HomeResponseKey.name]}'),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Switch(
                                value: state.isCelsius,
                                onChanged: (value) {
                                  state.isCelsius = value;
                                  state.convertTemperature(state.isCelsius ? state.celsius : state.fahrenheit, state.isCelsius);
                                },
                                activeTrackColor: Colors.lightBlueAccent,
                                activeColor: Colors.blue,
                              ),
                              Text(state.isCelsius ? HomeScreenKey.celsius : HomeScreenKey.fahrenheit),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ) : const Center(child: CircularProgressIndicator()),
              ),
            ),
          ));
    });
  }
}
