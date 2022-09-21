
import 'package:flutter/material.dart';

import 'package:weatherapp/data/models/city_weather.dart';

class CityCard extends StatelessWidget {
  CityCard({
    Key? key,
    required this.size,
    required this.weather,
    required this.press,
  }) : super(key: key);

  final Size size;
  final Weather weather;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(
          right: 10,
          left: 10,
          top: 20,
          bottom: 20,
        ),
        child: Stack(children: [
          Hero(
              tag: "${weather.id}-background",
              child: Container(
                  width: size.width * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        offset: const Offset(0, 5),
                        blurRadius: 15.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ))),
          SizedBox(
            width: size.width * 0.8,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
                        tag: "${weather.id}-icon",
                        child: const Icon(Icons.bubble_chart_rounded,color: Colors.blue,),
                      ),
                      const Icon(Icons.pinch_sharp,color: Colors.blue,)
                    ],
                  ),

                  Hero(
                    tag: "${weather.id}-name",
                    child: Text(
                      weather.destination,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.grey[700]),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${(weather.temp! - 273.15).round()}°",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.arrow_upward,color: Colors.green,),
                          Text(
                            "${(weather.tempMax! - 273.15).round()}°",
                            style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.arrow_downward,color: Colors.red,),
                          Text(
                            "${(weather.tempMin! - 273.15).round()}°",
                            style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Hero(
                          tag: "${weather.id}-count",
                          child: Text(
                            weather.weatherStateMain,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Colors.grey[700]),
                          ),
                        ),
                      ),
                      Hero(
                          tag: "${weather.id}-task",
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/loading.gif',
                            
                            image:
                                'http://openweathermap.org/img/wn/${weather.weatherStateIcon}@2x.png',
                            height: 100,
                            width: 100,
                          )),
                    ],
                  ),
                  
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
