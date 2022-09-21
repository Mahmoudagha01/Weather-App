import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/business_logic/weather_cubit.dart';
import 'package:weatherapp/business_logic/weather_state.dart';
import 'package:weatherapp/data/models/city_weather.dart';
import 'package:weatherapp/presentation/widgets/city_card.dart';
import 'package:weatherapp/utilities/routes.dart';

import '../../utilities/constants.dart';
import '../../utilities/greeting.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _fetchInitial();
    _fetchInitial2();
    super.initState();
  }

  Future<void> _fetchInitial() async {
    BlocProvider.of<CityWeatherCubit>(context).getTopCities();
  }

  void _fetchInitial2()  {
     BlocProvider.of<CityWeatherCubit>(context).getFiveDaysWeather(city: "cairo");
  }

  Weather? cityWeather;

  final _pageScroll = PageController(viewportFraction: 0.85, keepPage: true);
  List<Color> currentColor = backColor[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CityWeatherCubit, CityWeatherState>(
      builder: (context, state) {
        List<Weather> cities =
            BlocProvider.of<CityWeatherCubit>(context).dataList;
        if (state is CityWeatherloading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CityWeatherloaded) {
          cityWeather = BlocProvider.of<CityWeatherCubit>(context).cityWeather;
          return AnimatedContainer(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: currentColor),
              ),
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
              child: Container(
                  child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        centerTitle: true,
                        title: Text("Weather App"),
                      ),
                      body: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.search);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 30,
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text('Enter City Name'),
                                      Icon(Icons.search),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Good ${greeting()} ,Mr Mahmoud",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(color: Colors.white),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 22),
                                      child: Text(
                                        DateFormat.yMMMEd()
                                            .format(DateTime.now()),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 400,
                                child: Padding(
                                    padding: EdgeInsets.zero,
                                    child: PageView.builder(
                                      allowImplicitScrolling: true,
                                      controller: _pageScroll,
                                      itemCount: cities.length,
                                      onPageChanged: (index) {
                                        setState(() {
                                          currentColor = backColor[index];
                                        });
                                      },
                                      itemBuilder: (context, index) {
                                        return CityCard(
                                          size: MediaQuery.of(context).size,
                                          weather: cities[index],
                                          press: () {
                                            Navigator.pushNamed(
                                                context, AppRoutes.details,
                                                arguments: cities[index]);
                                          },
                                        );
                                      },
                                    )),
                              )
                            ],
                          ),
                        ),
                      ))));
        } else if (state is CityWeatherError) {
          return Center(
            child: Text("fail"),
          );
        } else {
          return Center(
            child: Text(""),
          );
        }
      },
    ));
  }
}
