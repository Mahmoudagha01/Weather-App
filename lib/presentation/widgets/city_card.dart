import 'package:flutter/material.dart';
import '../../data/models/weather.dart';
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
              tag: "${weather.city.id}-background",
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
                        tag: "${weather.city.id}-icon",
                        child: const Icon(Icons.bubble_chart_rounded,color: Colors.blue,),
                      ),
                      const Icon(Icons.pinch_sharp,color: Colors.blue,)
                    ],
                  ),

                  Hero(
                    tag: "${weather.city.id}-name",
                    child: Text(
                      weather.city.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.grey[700]),
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        Text(
                          "${(weather.list[0].main.temp - 273.15).round()}°",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.arrow_upward,color: Colors.green,),
                            Text(
                              "${(weather.list[0].main.tempMax - 273.15).round()}°",
                              style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.arrow_downward,color: Colors.red,),
                            Text(
                              "${(weather.list[0].main.tempMin - 273.15).round()}°",
                              style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Hero(
                            tag: "${weather.city.id}-count",
                            child: Text(
                              weather.list[0].weather[0].main,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: Colors.grey[700]),
                            ),
                          ),
                        ),
                        Hero(
                            tag: "${weather.city.id}",
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loading.gif',
                              
                              image:
                                  'http://openweathermap.org/img/wn/${weather.list[0].weather[0].icon}@2x.png',
                              height: 100,
                              width: 100,
                            )),
                      ],
                    ),
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
