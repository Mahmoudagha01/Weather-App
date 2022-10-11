import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weatherapp/data/models/weather.dart';

import '../../data/models/Listelement.dart';

class MyChart extends StatelessWidget {
  final Weather weather;

  const MyChart({super.key, required this.weather});
  @override
  Widget build(BuildContext context) {
    return Container(
  
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
     height: MediaQuery.of(context).size.height * 0.25,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(arrangeByIndex: true),
        series: <ChartSeries<ListElement, String>>[
          SplineSeries<ListElement, String>(
            dataSource: weather.list,
            color: Colors.red,
            xValueMapper: (ListElement f, _) =>
                DateFormat.yMd().format(f.dtTxt).toString(),
            yValueMapper: (ListElement f, _) => f.main.temp - 273.15,
          ),
        ],
      ),
    );
  }
}
