import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/business_logic/weather_cubit.dart';
import 'package:weatherapp/data/models/city_weather.dart';
import 'package:weatherapp/data/models/forecast_weather.dart';
import '../../business_logic/weather_state.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.weather});
  final Weather weather;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  // @override
  // void initState() {
  // //  _fetchInitial();
  //   super.initState();
  // }

//  Future<void> _fetchInitial() async {
//     await context.read<CityWeatherCubit>().getFiveDaysWeather(city: "Cairo");
//   }

  ForecastWeather? dayWeather;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 161, 161),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            const Text("Weather App"),
            Text(
              DateFormat.yMMMEd().format(DateTime.now()),
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
      body: BlocBuilder<CityWeatherCubit, CityWeatherState>(
          builder: (context, state) {
        List dayslist = BlocProvider.of<CityWeatherCubit>(context).daysList;
        if (state is CityWeatherloading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CityWeatherloaded) {
          dayWeather = BlocProvider.of<CityWeatherCubit>(context).dayWeather;
          return Column(children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: const BoxDecoration(
                      color: Color(0xFF403b4a),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(100),
                        topRight: Radius.circular(100),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: Column(
                        children: [
                          Row(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      widget.weather.destination.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Colors.white),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    widget.weather.weatherStateDescription,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "${(widget.weather.temp! - 273.15).round()}°",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                          ]),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.white30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    foregroundColor: Colors.white,
                                    child: Icon(Icons.air)),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Wind",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      "${(widget.weather.speed)!.floor()} km/h",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    foregroundColor: Colors.white,
                                    child: Icon(Icons.water_drop)),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Humidity",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      "${widget.weather.humidity}%",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 200,
                    height: 200,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image:
                          'http://openweathermap.org/img/wn/${widget.weather.weatherStateIcon}@2x.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text("${dayslist}"),
            )
          ]);
        } else if (state is CityWeatherError) {
          return Center(
            child: Text("fail"),
          );
        } else {
          return Center(
            child: Text("p"),
          );
        }
      }),
    );
  }
}
