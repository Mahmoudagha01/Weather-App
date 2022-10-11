import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/business_logic/weather_cubit.dart';
import 'package:weatherapp/data/models/weather.dart';
import 'package:weatherapp/presentation/widgets/header.dart';
import '../../business_logic/weather_state.dart';
import '../../data/models/Listelement.dart';
import '../widgets/chart.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.weather});
  final Weather weather;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  Weather? dayWeather;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 113, 80, 80),
      // const Color.fromARGB(255, 161, 161, 161),
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
        if (state is CityWeatherloading) {
          return Center(
            child: Image.asset("assets/images/loading.gif"),
          );
        } else if (state is CityWeatherSuccess) {
          dayWeather = BlocProvider.of<CityWeatherCubit>(context).cityWeather;
          final List<ListElement> days = [];
          final apiList = dayWeather!.list;

          // Filter Api response list to only five days list.
          days.add(apiList.first);
          for (var i in apiList) {
            if (days.last.dtTxt.day != i.dtTxt.day) {
              days.add(i);
            }
          }

          return Column(children: [
            Header(weather: widget.weather),
            MyChart(weather: widget.weather),
            Expanded(
              child: Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  itemCount: days.length,
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        days[index].dtTxt.weekday == DateTime.now().weekday
                            ? "Today"
                            : (DateFormat.EEEE().format(days[index].dtTxt)),
                        style: Theme.of(context)
                            .copyWith()
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          '${days[index].weather[0].main}',
                          style: Theme.of(context)
                              .copyWith()
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading.gif',
                          image:
                              'http://openweathermap.org/img/wn/${widget.weather.list[index].weather[0].icon}@2x.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.arrow_upward,
                                color: Colors.green,
                              ),
                              Text(
                                "${(days[0].main.tempMax - 273.15).round()}°",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.green),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.arrow_downward,
                                color: Colors.red,
                              ),
                              Text(
                                "${(days[0].main.tempMin - 273.15).round()}°",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]);
        } else if (state is CityWeatherError) {
          return Center(
            //Todo: handle error msg
            child: Text("fail"),
          );
        } else {
          return Center(
            child: Text("none"),
          );
        }
      }),
    );
  }
}
